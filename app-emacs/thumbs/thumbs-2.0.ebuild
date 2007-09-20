# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thumbs/thumbs-2.0.ebuild,v 1.1 2007/09/20 22:07:15 ulm Exp $

inherit elisp

DESCRIPTION="Emacs thumbnail previewer for image files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ThumbsMode"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-gfx/imagemagick"

SIMPLE_ELISP=t
SITEFILE=51${PN}-gentoo.el
