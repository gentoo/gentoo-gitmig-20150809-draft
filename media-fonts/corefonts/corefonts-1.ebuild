# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/corefonts/corefonts-1.ebuild,v 1.8 2004/11/04 11:46:07 usata Exp $

DESCRIPTION="Microsoft's TrueType core fonts"
HOMEPAGE="http://corefonts.sourceforge.net/"
SRC_URI="mirror://sourceforge/corefonts/andale32.exe
	mirror://sourceforge/corefonts/arial32.exe
	mirror://sourceforge/corefonts/arialb32.exe
	mirror://sourceforge/corefonts/comic32.exe
	mirror://sourceforge/corefonts/courie32.exe
	mirror://sourceforge/corefonts/georgi32.exe
	mirror://sourceforge/corefonts/impact32.exe
	mirror://sourceforge/corefonts/times32.exe
	mirror://sourceforge/corefonts/trebuc32.exe
	mirror://sourceforge/corefonts/verdan32.exe
	mirror://sourceforge/corefonts/webdin32.exe"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc alpha ~mips ~hppa ia64"
IUSE=""

DEPEND="app-arch/cabextract"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		cabextract --lowercase ${DISTDIR}/${exe} > /dev/null \
			|| die "failed to unpack ${exe}"
	done
}

src_install() {
	insinto /usr/share/fonts/${PN}
	doins *.ttf
}
