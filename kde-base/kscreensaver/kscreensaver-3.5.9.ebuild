# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscreensaver/kscreensaver-3.5.9.ebuild,v 1.3 2008/05/12 16:23:33 armin76 Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE screensaver framework"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility opengl"
DEPEND="opengl? ( virtual/opengl )"

RDEPEND="${DEPEND}"

src_compile() {
	myconf="$myconf $(use_with opengl gl)"
	kde-meta_src_compile
}
