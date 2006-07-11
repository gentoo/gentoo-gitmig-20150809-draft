# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/tengwar-fonts/tengwar-fonts-1.9d.ebuild,v 1.10 2006/07/11 21:47:44 agriffis Exp $

inherit font

DESCRIPTION="Tengwar - the Elvish letters, created by Feanor and described by J.R.R.Tolkien)"
HOMEPAGE="http://www.tengwar.art.pl/ktt/en/download.php"
SRC_URI="
	http://www.tengwar.art.pl/zip/tengq19d.zip
	http://www.tengwar.art.pl/zip/tengs19d.zip
	http://www.tengwar.art.pl/zip/tengn19d.zip
	http://www.tengwar.art.pl/zip/parmaite12b.zip
	http://www.tengwar.art.pl/zip/tcurs100.zip
"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf TTF"
DOCS="*.txt *.TXT *.rtf *.pdf"
