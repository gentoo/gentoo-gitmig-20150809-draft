# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linkers-and-loaders/linkers-and-loaders-0.ebuild,v 1.1 2005/01/15 00:51:33 vapier Exp $

CH="|00e |01e |02e |03e |04e |05e |06e |07e |08e |09e |10e |11e |12e"
DESCRIPTION="the Linkers and Loaders book"
HOMEPAGE="http://www.iecc.com/linker/"
SRC_URI="doc? ( ${CH//e/.txt} ${CH//e/.rtf} ) ${CH//e/.html}"
SRC_URI="${SRC_URI//|/${HOMEPAGE}linker}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"
RESTRICT="nomirror"

DEPEND=""

S="${WORKDIR}"

src_unpack() {
	local f
	for f in ${A} ; do
		cp "${DISTDIR}"/${f} . || die "copying ${f}"
	done
}

src_install() {
	dohtml *.html || die
	use doc && dodoc *.txt *.rtf
}
