# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thumbs/thumbs-1.8.ebuild,v 1.2 2004/04/06 03:49:10 vapier Exp $

inherit elisp eutils

DESCRIPTION="Emacs thumbnail previewer for image files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ThumbsMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	media-gfx/imagemagick"

SITEFILE=50thumbs-gentoo.el

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/thumbs.el-gentoo.patch
}

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
