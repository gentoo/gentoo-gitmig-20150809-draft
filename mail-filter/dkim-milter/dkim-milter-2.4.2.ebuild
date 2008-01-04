# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dkim-milter/dkim-milter-2.4.2.ebuild,v 1.1 2008/01/04 10:30:29 mrness Exp $

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
	|| ( mail-filter/libmilter mail-mta/sendmail )
	diffheaders? ( dev-libs/tre )"
DEPEND="${RDEPEND}"

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

	newinitd "${FILESDIR}/dkim-filter-2.4.1-init" dkim-filter \
		|| die "newinitd failed"

	# prepare directory for .pid, .sock and .stats files
	dodir /var/run/dkim-filter
	fowners milter:milter /var/run/dkim-filter

	dodir /usr/bin
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
		openssl genrsa -out "${ROOT}"etc/mail/dkim-filter/${selector}.private ${keysize} && \
			chown milter:milter "${ROOT}"etc/mail/dkim-filter/${selector}.private && chmod u=r,g-rwx,o-rwx "${ROOT}"etc/mail/dkim-filter/${selector}.private &&
			openssl rsa -in "${ROOT}"etc/mail/dkim-filter/${selector}.private -out "${ROOT}"etc/mail/dkim-filter/${selector}.public -pubout -outform PEM || \
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
	{
		local line
		pubkey=
		while read line; do
			[[ "${line}" == "--"* ]] || pubkey="${pubkey}${line}"
		done
	} < "${ROOT}"etc/mail/dkim-filter/${selector}.public
	echo
	einfo "After you configured your MTA, publish your key by adding this TXT record to your domain:"
	einfo "  ${selector}._domainkey   IN   TXT  \"v=DKIM1\\; k=rsa\\; t=y\\; p=${pubkey}\""
	echo
	einfo "t=y signifies you only test the DKIM on your domain. See following page for the complete list of tags:"
	einfo "  http://www.dkim.org/specs/rfc4871-dkimbase.html#key-text"
}
