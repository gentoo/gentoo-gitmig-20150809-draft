# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/elogv/elogv-0.6.1-r2.ebuild,v 1.1 2008/02/04 09:18:42 opfer Exp $

inherit eutils

DESCRIPTION="Curses based utility to parse the contents of elogs created by Portage"
HOMEPAGE="http://gechi-overlay.sourceforge.net/?page=elogv"
SRC_URI="mirror://sourceforge/gechi-overlay/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/portage-2.1"

pkg_setup() {
	if ! built_with_use dev-lang/python ncurses; then
	   eerror
	   eerror "\t ${PN} requires ncurses support on python"
	   eerror "\t Please, compile python with use ncurses enabled then"
	   eerror "\t remerge this package"
	   eerror
	   die "dev-lang/python must have ncurses use turned on"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 195429
	epatch "${FILESDIR}/${P}-segfault_delete.patch"
	# bug 208524
	epatch "${FILESDIR}/${P}-refresh_screen.patch"
	# on user request
	epatch "${FILESDIR}/${P}-vi_movement.patch"
}
src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	newbin elogv.py elogv || die "newbin failed"
	doman elogv.1
	dodoc README AUTHORS ChangeLog ChangeLog.old
	# This will be used as soon as the Makefile is ready for BSD
	# see bug 192514
#	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog
	elog "In order to use this software, you need to activate"
	elog "Portage's elog features.  Required is"
	elog "		 PORTAGE_ELOG_SYSTEM=\"save\" "
	elog "and at least one out of "
	elog "		 PORTAGE_ELOG_CLASSES=\"warn error info log qa\""
	elog "More information on the elog system can be found"
	elog "in /etc/make.conf.example"
	elog
	elog "To operate properly this software needs the directory"
	elog "${PORT_LOGDIR:-/var/log/portage}/elog created, belonging to group portage."
	elog "To start the software as a user, add yourself to the portage"
	elog "group."
	elog
}
