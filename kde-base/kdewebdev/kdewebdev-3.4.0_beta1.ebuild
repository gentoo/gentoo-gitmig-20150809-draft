# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.4.0_beta1.ebuild,v 1.4 2005/01/16 17:23:10 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~x86"
IUSE="doc tidy"

DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )
	tidy? ( app-text/htmltidy )
	!app-editors/quanta
	!app-text/kfilereplace
	!media-gfx/kimagemapeditor"

src_install() {
	kde_src_install

	# Collision with kdelibs. Will be fixed for beta2.
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/next.png
	rm -f ${D}/${KDEDIR}/share/icons/crystalsvg/22x22/actions/back.png
}
