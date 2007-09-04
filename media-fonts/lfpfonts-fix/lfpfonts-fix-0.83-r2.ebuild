# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-fix/lfpfonts-fix-0.83-r2.ebuild,v 1.6 2007/09/04 02:49:19 dirtyepic Exp $

inherit font eutils font-ebdftopcf

DESCRIPTION="Linux Font Project fixed-width fonts"
SRC_URI="mirror://sourceforge/xfonts/${PN}-src-${PV}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${PN}-src"

FONT_SUFFIX="pcf.gz"
FONT_S="${S}/src"

DOCS="${S}/doc/*"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PN}-0.83-noglyph.patch
}

src_compile() {
	cd "${FONT_S}"
	for a in *.bdf; do
		cat < ${a} | ( rm ${a}; sed '/^FONT /s/\(.*-\)C*-/\1C-/' > ${a} )
	done

	ebdftopcf *.bdf
}
