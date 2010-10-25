# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr/vmailmgr-0.97-r1.ebuild,v 1.2 2010/10/25 08:41:29 ssuominen Exp $

EAPI="2"

inherit toolchain-funcs eutils autotools

DESCRIPTION="virtual domains for qmail"
HOMEPAGE="http://www.vmailmgr.org/"
SRC_URI="http://www.vmailmgr.org/archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/ucspi-unix-0.34
	virtual/qmail
	>=net-mail/qmail-autoresponder-0.95"

src_prepare() {
	sed -i \
		-e 's:vadduser.pod vadduser.pod:vadduser.pod:' \
		commands/Makefile.am || die #327431

	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-strcasestr.patch
	eautoreconf
}

src_install() {
	emake "DESTDIR=${D}" install || die "emake install failed"

	dodoc AUTHORS README TODO NEWS
	dohtml doc/*.html daemon/*.html authenticate/*.html commands/*.html
	docinto cgi
	dohtml cgi/*.html

	exeinto /var/lib/supervise/vmailmgrd
	newexe "${S}/scripts/vmailmgrd.run" run || die "failed to install vmailmgrd/run script"

	exeinto /var/lib/supervise/vmailmgrd/log
	newexe "${S}/scripts/vmailmgrd-log.run" run || die "failed to install vmailmgrd/log/run script"

	exeinto /etc/vmailmgr
	newexe "${S}/scripts/autoresponder.sh" vdeliver-postdeliver || die "failed to install vdeliver-postdeliver"

	doexe "${FILESDIR}/checkvpw-loginfail" || die "failed to install checkvpw-loginfail"

	insinto /etc/vmailmgr
	doins "${FILESDIR}/socket-file"
	doins "${FILESDIR}/separators"
}

pkg_postinst() {
	ewarn "CAUTION: courier-authlib does not support vmailmgr!"
	ewarn "If you want to use vmailmgr in conjuction with courier-imap,"
	ewarn "you should use imapfront-auth found in net-mail/mailfront package."
	ewarn
	ewarn "vcheckquota and vpopbull are now available through vmailmgr-tools package."
	ewarn "If you need them, run the following command:"
	ewarn "   emerge net-mail/vmailmgr-tools"
	echo
	elog "To start vmailmgrd you need to link"
	elog "/var/lib/supervise/vmailmgrd to /service"
}
