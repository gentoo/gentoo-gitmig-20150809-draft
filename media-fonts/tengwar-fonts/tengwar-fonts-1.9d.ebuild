# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/tengwar-fonts/tengwar-fonts-1.9d.ebuild,v 1.3 2004/11/01 17:51:19 corsair Exp $

inherit font

DESCRIPTION="Tengwar - the Elvish letters, created by Fanor and described by J.R.R.Tolkien)"
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
KEYWORDS="~x86 ~ppc ~ppc64"

DEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf TTF"
DOCS="*.txt *.TXT *.rtf *.pdf"
