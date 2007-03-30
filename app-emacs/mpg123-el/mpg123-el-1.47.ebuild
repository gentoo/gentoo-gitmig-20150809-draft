# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mpg123-el/mpg123-el-1.47.ebuild,v 1.3 2007/03/30 22:11:08 opfer Exp $

inherit elisp toolchain-funcs

IUSE="vorbis"

DESCRIPTION="Emacs front-end to mpg123 audio player and OggVorbis audio player"
HOMEPAGE="http://www.gentei.org/~yuuji/software/mpg123el/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

DEPEND=""
RDEPEND="${DEPEND}
	virtual/mpg123
	media-sound/aumix
	vorbis? ( media-sound/vorbis-tools )"

SLOT="0"
LICENSE="freedist"
KEYWORDS="~amd64 ~ppc x86"

SITEFILE="50mpg123-el-gentoo.el"

src_compile(){
	sed -i -e "s/\(mainloop:\)/\1 ;/" tagput.c || die
	"$(tc-getCC)" ${CFLAGS} -o tagput tagput.c || die
	"$(tc-getCC)" ${CFLAGS} -o id3put id3put.c || die
	elisp-compile *.el
}

src_install(){
	dobin tagput || die
	dobin id3put || die

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc README
}
