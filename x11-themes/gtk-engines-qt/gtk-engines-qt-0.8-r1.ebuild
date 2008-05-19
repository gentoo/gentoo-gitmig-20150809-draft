# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.8-r1.ebuild,v 1.1 2008/05/19 00:03:48 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt 3 Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND=">=x11-libs/gtk+-2.2
	dev-util/cmake"
# the little gnome_apps.png...
RDEPEND="|| ( =kde-base/kdebase-data-3.5* =kde-base/kdebase-3.5* )
	>=x11-libs/gtk+-2.2"
need-kde 3.5

# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S="${WORKDIR}/${MY_PN}"

PATCHES="${FILESDIR}/gtk-engines-qt-0.8-konq-flash.patch"

src_install() {
	kde_src_install
	mv "${D}"/usr/local/share/{locale,applications} "${D}"/usr/share/ || die
}
