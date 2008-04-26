# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/elogv/elogv-0.6.4.ebuild,v 1.3 2008/04/26 01:55:06 ken69267 Exp $

inherit distutils eutils

DESCRIPTION="Curses based utility to parse the contents of elogs created by Portage"
HOMEPAGE="http://gechi-overlay.sourceforge.net/?page=elogv"
SRC_URI="mirror://sourceforge/gechi-overlay/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
# remove this after the release of 2008.0
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

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	distutils_src_install
	dodoc README ChangeLog ChangeLog.old
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
