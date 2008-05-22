# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.81_rc1.ebuild,v 1.7 2008/05/22 23:16:32 ingmar Exp $

inherit kde eutils

DESCRIPTION="Kuroo is a KDE Portage frontend."
HOMEPAGE="http://kuroo.org/"
SRC_URI="http://files.kuroo.org/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=app-portage/gentoolkit-0.2.3-r1
		>=kde-misc/kdiff3-0.9.92
		>=dev-db/sqlite-2.8.16-r4
	|| ( =kde-base/kdesu-3.5* =kde-base/kdebase-3.5* )"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

pkg_postinst() {
	kde_pkg_postinst

	# Bug 220175
	ewarn "NOTE: As of >=sys-apps/portage-2.1.5 the 'Updating Portage cache' routine"
	ewarn "\t isn't run anymore at the end of 'emerge --sync', even though ${PN} relies on said cache."
	ewarn "\tTo fully use ${PN}, add FEATURES=\"${FEATURES} metadata-transfer\" to /etc/make.conf."
}
