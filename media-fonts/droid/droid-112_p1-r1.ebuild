# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/droid/droid-112_p1-r1.ebuild,v 1.1 2010/01/07 19:54:16 spatz Exp $

EAPI="2"

inherit font

MY_PN="${PN/d/D}"

# $PV is a build number, use fontforge to find it out. 112 was taken from:
# http://android.git.kernel.org/?p=platform/frameworks/base.git;a=tree;f=data/fonts;hb=HEAD
DESCRIPTION="Font family from Google's Android project"
HOMEPAGE="http://code.google.com/android/RELEASENOTES.html"
SRC_URI="mirror://gentoo/${P}.tar.gz
	slashed? ( mirror://gentoo/${MY_PN}SansMonoSlashed-${PV}.ttf.bz2 )
	!slashed? ( dotted? ( mirror://gentoo/${MY_PN}SansMonoDotted-${PV}.ttf.bz2 ) )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dotted slashed"

S=${WORKDIR}/${PN}
FONT_S=${WORKDIR}/${PN}
FONT_SUFFIX="ttf"

RDEPEND=""
DEPEND=""

src_prepare() {
	if use slashed; then
		mv "${WORKDIR}/${MY_PN}SansMonoSlashed-${PV}.ttf" \
			"${S}/${MY_PN}SansMono.ttf"
	elif use dotted; then
		mv "${WORKDIR}/${MY_PN}SansMonoDotted-${PV}.ttf" \
			"${S}/${MY_PN}SansMono.ttf"
	fi
}
