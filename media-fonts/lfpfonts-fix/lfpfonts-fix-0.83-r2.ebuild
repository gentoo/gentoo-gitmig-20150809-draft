# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-fix/lfpfonts-fix-0.83-r2.ebuild,v 1.3 2006/01/11 16:02:04 agriffis Exp $

inherit font eutils

DESCRIPTION="Linux Font Project fixed-width fonts"
SRC_URI="mirror://sourceforge/xfonts/${PN}-src-${PV}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="x86 sparc ppc alpha amd64 ia64"
IUSE=""

S=${WORKDIR}/${PN}-src

FONT_SUFFIX="pcf.gz"

FONT_S=${S}/lfp-fix

DOCS="doc/*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.83-noglyph.patch
}

src_compile() {
	cd src
	for a in *.bdf; do
		cat < ${a} | ( rm ${a}; sed '/^FONT /s/\(.*-\)C*-/\1C-/' > ${a} )
	done

	# use built-in ucs2any
	PATH=".:${PATH}" ./compile || die "compile failed"
}
