# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mpg123-el/mpg123-el-1.42.ebuild,v 1.3 2004/10/09 20:04:24 usata Exp $

inherit gcc elisp

IUSE="oggvorbis"

DESCRIPTION="Emacs front-end to mpg123 audio player and OggVorbis audio player"
HOMEPAGE="http://www.gentei.org/~yuuji/software/mpg123el/"
# source bits are taken from the site above
SRC_URI="mirror://gentoo/${P}.tar.bz2"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	virtual/mpg123
	media-sound/aumix
	oggvorbis? ( media-sound/vorbis-tools )"

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86"

SITEFILE="50mpg123-el-gentoo.el"

src_compile(){
	$(gcc-getCC) ${CFLAGS} -o tagput tagput.c || die
	$(gcc-getCC) ${CFLAGS} -o id3put id3put.c || die
	elisp-compile *.el
}

src_install(){
	dobin tagput || die
	dobin id3put || die

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc README
}
