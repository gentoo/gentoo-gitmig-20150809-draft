# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thumbs/thumbs-1.8.ebuild,v 1.9 2007/07/03 19:45:38 ulm Exp $

inherit elisp eutils

DESCRIPTION="Emacs thumbnail previewer for image files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ThumbsMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

DEPEND="media-gfx/imagemagick"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/thumbs.el-gentoo.patch"
}
