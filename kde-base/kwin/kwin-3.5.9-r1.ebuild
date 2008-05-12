# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.9-r1.ebuild,v 1.3 2008/05/12 20:03:34 ranger Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"

RDEPEND="xcomposite? ( x11-libs/libXcomposite x11-libs/libXdamage )"
DEPEND="${RDEPEND}"

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-05.tar.bz2
	mirror://gentoo/kde-3.5.9-seli-xinerama.tar.bz2"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}

# Xinerama patch by Lubos Lunak.
# http://ktown.kde.org/~seli/xinerama/
PATCHES=( "${WORKDIR}/kdebase-kwin-only-seli-xinerama.patch" )
