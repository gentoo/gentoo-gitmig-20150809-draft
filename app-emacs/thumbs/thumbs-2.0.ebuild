# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/thumbs/thumbs-2.0.ebuild,v 1.6 2009/05/05 08:10:19 fauli Exp $

inherit elisp eutils

DESCRIPTION="Emacs thumbnail previewer for image files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ThumbsMode"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="media-gfx/imagemagick"
RDEPEND="${DEPEND}"

SITEFILE=51${PN}-gentoo.el
