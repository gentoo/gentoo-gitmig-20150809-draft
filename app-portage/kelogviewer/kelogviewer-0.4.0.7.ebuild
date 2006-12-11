# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kelogviewer/kelogviewer-0.4.0.7.ebuild,v 1.3 2006/12/11 12:00:07 opfer Exp $

DESCRIPTION="KDE based utility to parse the contents of elogs created by Portage"
HOMEPAGE="http://sourceforge.net/projects/elogviewer"
SRC_URI="mirror://sourceforge/elogviewer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/portage-2.1
	dev-python/PyQt
	kde-base/pykde"

src_install() {
	dobin "${WORKDIR}"/kelogviewer
}

pkg_postinst() {
	elog
	elog "In order to use this software, you need to activate"
	elog "Portage's elog features.  Required is"
	elog "	     PORTAGE_ELOG_SYSTEM=\"save\" "
	elog "and at least one out of "
	elog "	     PORTAGE_ELOG_CLASSES=\"warn error info log\""
	elog "More information on the elog system can be found"
	elog "in /etc/make.conf.example"
	elog
	elog "To operate properly this software needs the directory"
	elog "$PORT_LOGDIR/elog created, belonging to group portage."
	elog "To start the software as a user, add yourself to the portage"
	elog "group."
	elog
}
