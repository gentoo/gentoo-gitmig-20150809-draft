# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/droid/droid-112.ebuild,v 1.3 2009/05/12 08:41:16 loki_val Exp $

inherit font

# $PV is a build number, use fontforge to find it out. 112 was taken from:
# http://android.git.kernel.org/?p=platform/frameworks/base.git;a=tree;f=data/fonts;hb=HEAD
DESCRIPTION="Font family from Google's Android project"
HOMEPAGE="http://code.google.com/android/RELEASENOTES.html"
SRC_URI="http://omploader.org/vMTFjOQ/DroidFamily-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"

RDEPEND=""
DEPEND="app-arch/unzip"
