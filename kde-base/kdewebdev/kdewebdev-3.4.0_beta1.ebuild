# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.4.0_beta1.ebuild,v 1.6 2005/02/02 11:57:05 lanius Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~x86 ~amd64"
IUSE="doc tidy"

DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )
	!app-editors/quanta
	!app-text/kfilereplace
	!media-gfx/kimagemapeditor"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )"

src_install() {
	kde_src_install

	# Collision with kdelibs. Will be fixed for beta2.
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/next.png
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/back.png
}
