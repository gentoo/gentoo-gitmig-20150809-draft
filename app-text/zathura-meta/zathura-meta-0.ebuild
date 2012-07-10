# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-meta/zathura-meta-0.ebuild,v 1.2 2012/07/10 19:57:46 ago Exp $

EAPI=4

DESCRIPTION="Meta package for app-text/zathura plugins"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="cb djvu +pdf postscript"

RDEPEND="app-text/zathura
	cb? ( app-text/zathura-cb )
	djvu? ( app-text/zathura-djvu )
	pdf? ( || ( app-text/zathura-pdf-poppler app-text/zathura-pdf-mupdf ) )
	postscript? ( app-text/zathura-ps )"
