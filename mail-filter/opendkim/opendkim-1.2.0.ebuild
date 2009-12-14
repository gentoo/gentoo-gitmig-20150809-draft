# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/opendkim/opendkim-1.2.0.ebuild,v 1.1 2009/12/14 03:05:11 dragonheart Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A milter-based application to provide DKIM signing and verification"
HOMEPAGE="http://opendkim.org"
SRC_URI="mirror://sourceforge/opendkim/${P}.tar.gz"

LICENSE="Sendmail-Open-Source BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+db asyncdns opendbx"

# FUTURE: unbound (dnssec lib) - bug #223103
# FUTURE: diffheaders (libtre error) - bug #296813

DEPEND="dev-libs/openssl
	db? ( >=sys-libs/db-3.2 )
	|| ( mail-filter/libmilter mail-mta/sendmail )
	opendbx? ( >=dev-db/opendbx-1.4.0 )"
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
	       -e 's:/etc/mail:/etc/opendkim:g' \
		   opendkim/opendkim.conf.sample
}

src_configure() {
	econf $(use_enable db bodylengthdb) \
		$(use_enable db popauth) \
		$(use_enable db query_cache) \
		$(use_enable db report_intervals) \
		$(use_enable db stats) \
		$(use_enable asyncdns arlib) \
		$(use_enable asyncdns dnsupgrade) \
		$(use_with opendbx odbx) \
		--without-domainkeys \
		--enable-capture_unknown_errors \
		--enable-dkim_reputation \
		--enable-identity_header \
		--enable-redirect \
		--enable-resign \
		--enable-replace_rules \
		--enable-select_canonicalization \
		--enable-selector_header \
		--enable-sender_macro \
		--enable-vbr \
		--enable-ztags
#		$(use_enable diffheaders) \
	# post release error found.
	use db && sed -i -e 's/_FFR_BODYLENGTHDB/_FFR_BODYLENGTH_DB/' build-config.h
}

src_install() {
	emake DESTDIR="${D}" install
	# file collision
	rm "${D}"/usr/share/man/man3/ar.3

	newinitd "${FILESDIR}/opendkim.init" opendkim
	dodir /etc/opendkim /var/run/opendkim /var/lib/opendkim
	fowners milter:milter /var/run/opendkim /etc/opendkim /var/lib/opendkim

	# default configuration
	if [ ! -f /etc/opendkim/opendkim.conf ]; then
		grep ^[^#] "${S}"/opendkim/opendkim.conf.sample \
			> "${D}"/etc/opendkim/opendkim.conf
		echo \# Socket local:/var/run/opendkim/opendkim.sock >> \
			"${D}"/etc/opendkim/opendkim.conf
		echo UserID milter >> "${D}"/etc/opendkim/opendkim.conf
		if use db; then
			echo Statistics /var/lib/opendkim/stats.db >> \
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
		opendkim-genkey.sh -b ${keysize} -D "${ROOT}"etc/opendkim/ \
			-s ${selector} && \
			chown milter:milter \
			"${ROOT}"etc/opendkim/"${selector}".private || \
				{ eerror "Failed to create private and public keys." ; return 1; }
		chmod go-r "${ROOT}"etc/opendkim/"${selector}".private
	fi

	# opendkim selector configuration
	echo
	einfo "Make sure you have the following settings in your dkim-filter.conf:"
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
