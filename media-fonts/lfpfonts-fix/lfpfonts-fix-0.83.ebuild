# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-fix/lfpfonts-fix-0.83.ebuild,v 1.1 2004/05/15 09:52:09 usata Exp $

S=${WORKDIR}/${PN}-src
DESCRIPTION="Linux Font Project fixed-width fonts"
SRC_URI="http://dreamer.nitro.dk/typography/${PN}-src-${PV}.tar.bz2"
HOMEPAGE="http://dreamer.nitro.dk/typography/bitmap-fonts.html"
LICENSE="public-domain"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 ~ia64"
SLOT="0"

# hopefully anything satisfying virtual/x11 will also provide bdftopcf
DEPEND="virtual/x11"
RDEPEND=""

src_compile() {
	cd src
	for a in *.bdf; do
		cat < ${a} | ( rm ${a}; sed '/^FONT /s/\(.*-\)C*-/\1C-/' > ${a} )
	done
	./compile || die "compile failed"
}

src_install() {
	dodoc doc/*
	cd lfp-fix
	insinto /usr/share/lfp-fix
	insopts -m0644
	doins * || die
}
