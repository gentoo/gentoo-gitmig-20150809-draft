# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cymbaline/cymbaline-1.2f.ebuild,v 1.1 2004/07/06 08:05:38 eradicator Exp $

IUSE="mikmod oggvorbis"

DESCRIPTION="Smart Command Line Mp3 Player"
HOMEPAGE="http://silmarill.org/cymbaline.htm"
SRC_URI="http://www.silmarill.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# -amd64: pyao borks
# -sparc: pyao and pymad bork
KEYWORDS="~x86 -amd64 -sparc"
RESTRICT="nostrip"

DEPEND="dev-lang/python
	dev-python/pymad
	dev-python/pyao
	media-sound/aumix
	mikmod? ( media-sound/mikmod )
	oggvorbis? ( media-sound/vorbis-tools ) "

src_compile() {
	einfo No compilation necessary.
}

src_install () {
	python setup.py install --root="${D}"
	dosym cymbaline.py /usr/bin/cymbaline
}
