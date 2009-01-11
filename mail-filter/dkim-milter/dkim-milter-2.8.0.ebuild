# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dkim-milter/dkim-milter-2.8.0.ebuild,v 1.1 2009/01/11 07:51:29 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A milter-based application to provide DomainKeys Identified Mail (DKIM) service"
HOMEPAGE="http://sourceforge.net/projects/dkim-milter/"
SRC_URI="mirror://sourceforge/dkim-milter/${P}.tar.gz"

LICENSE="Sendmail-Open-Source"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 diffheaders"

RDEPEND="dev-libs/openssl
	>=sys-libs/db-3.2
	diffheaders? ( dev-libs/tre )"
DEPEND="${RDEPEND}
	|| ( mail-filter/libmilter mail-mta/sendmail )" # libmilter is a static library

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter
}

src_unpack() {
	unpack ${A}

	cd "${S}" || die "source dir not found"

	cp site.config.m4.dist devtools/Site/site.config.m4 || \
		die "failed to copy site.config.m4"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	local ENVDEF=""
	use ipv6 && ENVDEF="${ENVDEF} -DNETINET6"
	sed -i -e "s:@@CFLAGS@@:${CFLAGS}:" -e "s:@@ENVDEF@@:${ENVDEF}:" \
		devtools/Site/site.config.m4
	echo "APPENDDEF(\`confNO_MAN_BUILD', \` ')">>devtools/Site/site.config.m4

	use diffheaders && epatch "${FILESDIR}/${PN}-diffheaders.patch"
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "emake failed"
}

src_test() {
	emake -j1 CC="$(tc-getCC)" OPTIONS=check \
		|| die "emake check failed"
}

src_install() {
	# no other program need to read from here
	dodir /etc/mail/dkim-filter
	fowners milter:milter /etc/mail/dkim-filter
	fperms 700 /etc/mail/dkim-filter

	insinto /etc/mail/dkim-filter
	newins dkim-filter/dkim-filter.conf.sample dkim-filter.conf

	newinitd "${FILESDIR}/dkim-filter.init" dkim-filter \
		|| die "newinitd failed"
	sed -i -e s:bin/dkim-filter:sbin/dkim-filter: "${D}/etc/init.d/dkim-filter" \
		|| die 'failed to correct dkim-filter path'

	# prepare directory for .pid, .sock and .stats files
	dodir /var/run/dkim-filter
	fowners milter:milter /var/run/dkim-filter

	dodir /usr/bin /usr/sbin
	emake -j1 DESTDIR="${D}" \
		SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
		install || die "make install failed"

	# man build is broken; do man page installation by hand
	doman */*.{3,5,8}

	# some people like docs
	dodoc RELEASE_NOTES *.txt
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
	if [[ -f "${ROOT}"etc/mail/dkim-filter/${selector}.private ]]; then
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
		dkim-genkey -b ${keysize} -D "${ROOT}"etc/mail/dkim-filter/ \
			-s ${selector} && \
			chown milter:milter \
			"${ROOT}"etc/mail/dkim-filter/"${selector}".private || \
				{ eerror "Failed to create private and public keys." ; return 1; }
	fi

	# dkim-filter selector configuration
	echo
	einfo "Make sure you have the following settings in your dkim-filter.conf:"
	einfo "  Keyfile /etc/mail/dkim-filter/${selector}.private"
	einfo "  Selector ${selector}"

	# MTA configuration
	echo
	einfo "If you are using Postfix, add following lines to your main.cf:"
	einfo "  smtpd_milters     = unix:/var/run/dkim-filter/dkim-filter.sock"
	einfo "  non_smtpd_milters = unix:/var/run/dkim-filter/dkim-filter.sock"

	# DNS configuration
	einfo "After you configured your MTA, publish your key by adding this TXT record to your domain:"
	cat "${ROOT}"etc/mail/dkim-filter/${selector}.txt
	einfo "t=y signifies you only test the DKIM on your domain. See following page for the complete list of tags:"
	einfo "  http://www.dkim.org/specs/rfc4871-dkimbase.html#key-text"
	einfo
	einfo "Also look at the draft ASP http://www.dkim.org/specs/draft-ietf-dkim-ssp-03.html"
}
