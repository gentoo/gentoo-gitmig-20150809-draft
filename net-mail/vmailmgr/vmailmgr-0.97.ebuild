# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr/vmailmgr-0.97.ebuild,v 1.5 2006/12/05 13:52:01 gustavoz Exp $

inherit toolchain-funcs eutils

DESCRIPTION="virtual domains for qmail"
HOMEPAGE="http://www.vmailmgr.org/"
SRC_URI="http://www.vmailmgr.org/archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=sys-apps/ucspi-unix-0.34
	virtual/qmail
	>=net-mail/qmail-autoresponder-0.95"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"

	#Remove support for courier-imap authentication
	#since it is incompatible with the latest version of courier-authlib
	epatch "${FILESDIR}/${P}-no-authvmailmgr.patch"
	rm -rf "${S}/lib/courier-authlib"
}

src_install() {
	make "DESTDIR=${D}" install || die "make install failed"

	dodoc AUTHORS README TODO NEWS
	dohtml doc/*.html daemon/*.html authenticate/*.html commands/*.html
	docinto cgi
	dohtml cgi/*.html

	exeinto /var/lib/supervise/vmailmgrd
	newexe "${S}/scripts/vmailmgrd.run" run

	exeinto /var/lib/supervise/vmailmgrd/log
	newexe "${S}/scripts/vmailmgrd-log.run" run

	exeinto /etc/vmailmgr
	newexe "${S}/scripts/autoresponder.sh" vdeliver-postdeliver

	doexe "${FILESDIR}/checkvpw-loginfail"

	insinto /etc/vmailmgr
	doins "${FILESDIR}/socket-file"
	doins "${FILESDIR}/separators"
}

pkg_postinst() {
	ewarn "CAUTION: courier-authlib does not support vmailmgr!"
	ewarn "If you want to use vmailmgr in conjuction with courier-imap,"
	ewarn "you should use imapfront-auth found in net-mail/mailfront package."
	echo
	ewarn "vcheckquota and vpopbull are now available through vmailmgr-tools package."
	ewarn "If you need them, run the following command:"
	ewarn "   emerge net-mail/vmailmgr-tools"
	echo
	einfo "To start vmailmgrd you need to link"
	einfo "/var/lib/supervise/vmailmgrd to /service"
}
