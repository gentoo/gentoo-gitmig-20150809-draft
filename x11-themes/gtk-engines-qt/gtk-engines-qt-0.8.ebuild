# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qt/gtk-engines-qt-0.8.ebuild,v 1.10 2008/07/28 21:57:04 carlo Exp $

EAPI=1

ARTS_REQUIRED="never"

inherit kde eutils qt3

MY_PN="gtk-qt-engine"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="${DEPEND}
	x11-libs/qt:3
	>=x11-libs/gtk+-2.2"

DEPEND="${RDEPEND}
	dev-util/cmake"

need-kde 3
# Set slot after the need-kde. Fixes bug #78455.
SLOT="2"

S=${WORKDIR}/${MY_PN}

src_install() {
	kde_src_install
	mv "${D}"/usr/local/share/{locale,applications} "${D}"/usr/share/ || die
}
