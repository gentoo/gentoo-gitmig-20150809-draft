# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/opendkim/opendkim-2.2.2.ebuild,v 1.1 2010/11/30 11:27:37 dragonheart Exp $

EAPI="2"

inherit eutils

# for betas
#MY_P=${P/_b/.B}
#S=${WORKDIR}/${PN}-2.0.0
#SRC_URI="mirror://sourceforge/opendkim/${MY_P}.tar.gz"

DESCRIPTION="A milter-based application to provide DKIM signing and verification"
HOMEPAGE="http://opendkim.org"
SRC_URI="mirror://sourceforge/opendkim/${P}.tar.gz"

LICENSE="Sendmail-Open-Source BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asyncdns +db opendbx ldap lua sasl unbound"

# FUTURE: diffheaders (libtre error) - bug #296813

DEPEND="dev-libs/openssl
	db? ( >=sys-libs/db-3.2 )
	|| ( mail-filter/libmilter mail-mta/sendmail )
	opendbx? ( >=dev-db/opendbx-1.4.0 )
	lua? ( dev-lang/lua )
	ldap? ( net-nds/openldap
		sasl? ( dev-libs/cyrus-sasl )
	)
	unbound? ( >=net-dns/unbound-1.4.1 net-dns/dnssec-root )"
#	diffheaders? ( dev-libs/tre )
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup milter
	# mail-milter/spamass-milter creates milter user with this home directory
	# For consistency reasons, milter user must be created here with this home directory
	# even though this package doesn't need a home directory for this user (#280571)
	enewuser milter -1 -1 /var/lib/milter milter
}

src_prepare() {
	sed -i -e 's:/var/db/dkim:/etc/opendkim:g' \
	       -e 's:/var/db/opendkim:/var/lib/opendkim:g' \
	       -e 's:/etc/mail:/etc/opendkim:g' \
	       -e 's:mailnull:milter:g' \
	       -e 's:^#[[:space:]]*PidFile.*:PidFile /var/run/opendkim/opendkim.pid:' \
		   opendkim/opendkim.conf.sample opendkim/opendkim.conf.simple.in \
		   contrib/opendkim-reportstats
}

src_configure() {
	local conf
	if use asyncdns ; then
		if use unbound; then
			conf=$(use_with unbound)
		else
			conf="$(use_enable asyncdns arlib)"
		fi
	else
		conf="$(use_with unbound) $(use_enable asyncdns arlib)"
	fi
	if use ldap; then
		conf="${conf} $(use_with sasl)"
	fi
	econf $(use_enable db bodylength_db) \
		$(use_enable db popauth) \
		$(use_enable db query_cache) \
		$(use_enable db report_intervals) \
		$(use_enable db stats) \
		$(use_enable db stats_i) \
		$(use_with opendbx odbx) \
		$(use_with lua) \
		$(use_enable lua statsext) \
		$(use_with ldap openldap) \
		$(use_enable ldap ldap_caching) \
		${conf} \
		--docdir=/usr/share/doc/${PF} \
		--without-domainkeys \
		--enable-adsp_lists \
		--enable-capture_unknown_errors \
		--enable-dkim_reputation \
		--enable-identity_header \
		--enable-redirect \
		--enable-resign \
		--enable-replace_rules \
		--enable-select_canonicalization \
		--enable-selector_header \
		--enable-default_sender \
		--enable-sender_macro \
		--enable-vbr
#		$(use_enable diffheaders) \
}

src_install() {
	emake DESTDIR="${D}" install
	# file collision
	rm -f "${D}"/usr/share/man/man3/ar.3

	dosbin contrib/opendkim-reportstats
	newinitd "${FILESDIR}/opendkim.init" opendkim
	dodir /etc/opendkim /var/run/opendkim /var/lib/opendkim
	fowners milter:milter /var/run/opendkim /etc/opendkim /var/lib/opendkim

	# default configuration
	if [ ! -f "${ROOT}"/etc/opendkim/opendkim.conf ]; then
		grep ^[^#] "${S}"/opendkim/opendkim.conf.simple \
			> "${D}"/etc/opendkim/opendkim.conf
		if use unbound; then
			echo TrustedAnchorFile /etc/dnssec/root-anchors.txt >> "${D}"/etc/opendkim/opendkim.conf
		fi
		echo UserID milter >> "${D}"/etc/opendkim/opendkim.conf
		if use db; then
			echo Statistics /var/lib/opendkim/stats.dat >> \
				"${D}"/etc/opendkim/opendkim.conf
		fi
	fi
}

pkg_postinst() {
	elog "If you want to sign your mail messages, you will have to run"
	elog "  emerge --config ${CATEGORY}/${PN}"
	elog "It will help you create your key and give you hints on how"
	elog "to configure your DNS and MTA."

	ewarn "Make sure your MTA has r/w access to the socket file."
	ewarn "This can be done either by setting UMask to 002 and adding MTA's user"
	ewarn "to milter group or you can simply set UMask to 000."
}

pkg_config() {
	local selector keysize pubkey

	read -p "Enter the selector name (default ${HOSTNAME}): " selector
	[[ -n "${selector}" ]] || selector=${HOSTNAME}
	if [[ -z "${selector}" ]]; then
		eerror "Oddly enough, you don't have a HOSTNAME."
		return 1
	fi
	if [[ -f "${ROOT}"etc/opendkim/${selector}.private ]]; then
		ewarn "The private key for this selector already exists."
	else
		einfo "Select the size of private key:"
		einfo "  [1] 512 bits"
		einfo "  [2] 1024 bits"
		while read -n 1 -s -p "  Press 1 or 2 on the keyboard to select the key size " keysize ; do
			[[ "${keysize}" == "1" || "${keysize}" == "2" ]] && echo && break
		done
		case ${keysize} in
			1) keysize=512 ;;
			*) keysize=1024 ;;
		esac

		# generate the private and public keys
		opendkim-genkey -b ${keysize} -D "${ROOT}"etc/opendkim/ \
			-s ${selector} -d '(your domain)' && \
			chown milter:milter \
			"${ROOT}"etc/opendkim/"${selector}".private || \
				{ eerror "Failed to create private and public keys." ; return 1; }
		chmod go-r "${ROOT}"etc/opendkim/"${selector}".private
	fi

	# opendkim selector configuration
	echo
	einfo "Make sure you have the following settings in your /etc/opendkim/opendkim.conf:"
	einfo "  Keyfile /etc/opendkim/${selector}.private"
	einfo "  Selector ${selector}"

	# MTA configuration
	echo
	einfo "If you are using Postfix, add following lines to your main.cf:"
	einfo "  smtpd_milters     = unix:/var/run/opendkim/opendkim.sock"
	einfo "  non_smtpd_milters = unix:/var/run/opendkim/opendkim.sock"

	# DNS configuration
	einfo "After you configured your MTA, publish your key by adding this TXT record to your domain:"
	cat "${ROOT}"etc/opendkim/${selector}.txt
	einfo "t=y signifies you only test the DKIM on your domain. See following page for the complete list of tags:"
	einfo "  http://www.dkim.org/specs/rfc4871-dkimbase.html#key-text"
	einfo
	einfo "Also look at the ADSP http://tools.ietf.org/html/rfc5617"
}
