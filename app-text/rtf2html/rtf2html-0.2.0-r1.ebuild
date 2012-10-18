# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rtf2html/rtf2html-0.2.0-r1.ebuild,v 1.2 2012/10/18 08:17:00 pinkbyte Exp $

EAPI="4"

inherit base

DESCRIPTION="RTF to HTML converter."
HOMEPAGE="http://rtf2html.sourceforge.net/"
SRC_URI="mirror://sourceforge/rtf2html/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README )

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )
