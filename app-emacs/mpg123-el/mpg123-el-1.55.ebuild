# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mpg123-el/mpg123-el-1.55.ebuild,v 1.2 2010/07/31 22:40:24 hwoarang Exp $

inherit elisp toolchain-funcs

DESCRIPTION="Emacs front-end to mpg123 audio player and OggVorbis audio player"
HOMEPAGE="http://www.gentei.org/~yuuji/software/mpg123el/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="vorbis"

DEPEND=""
RDEPEND="media-sound/mpg123
	media-sound/aumix
	vorbis? ( media-sound/vorbis-tools )"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	sed -i -e "s/\(mainloop:\)/\1 ;/" tagput.c || die
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o tagput tagput.c || die
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o id3put id3put.c || die
	elisp-compile *.el || die
}

src_install() {
	dobin tagput id3put || die
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
