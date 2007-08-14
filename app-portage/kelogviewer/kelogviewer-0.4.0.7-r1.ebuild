# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kelogviewer/kelogviewer-0.4.0.7-r1.ebuild,v 1.1 2007/08/14 11:44:54 opfer Exp $

inherit eutils

DESCRIPTION="KDE based utility to parse the contents of elogs created by Portage"
HOMEPAGE="http://sourceforge.net/projects/elogviewer"
SRC_URI="mirror://sourceforge/elogviewer/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/portage-2.1
	dev-python/PyQt
	>=dev-python/pykde-3.16.0"

src_install() {
	dobin "${WORKDIR}"/kelogviewer
	make_desktop_entry kelogviewer Kelogviewer "" "System" ||
		die "Couldn't make desktop entry"
}

pkg_postinst() {
	elog
	elog "In order to use this software, you need to activate"
	elog "Portage's elog features.	Required is"
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
