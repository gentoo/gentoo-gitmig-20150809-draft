# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lfpfonts-fix/lfpfonts-fix-0.83-r1.ebuild,v 1.5 2004/09/29 07:45:11 usata Exp $

S=${WORKDIR}/${PN}-src
DESCRIPTION="Linux Font Project fixed-width fonts"
SRC_URI="mirror://sourceforge/xfonts/${PN}-src-${PV}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/xfonts/"
LICENSE="public-domain"
KEYWORDS="x86 sparc ppc alpha amd64 ia64"
IUSE=""
SLOT="0"

# hopefully anything satisfying virtual/x11 will also provide bdftopcf
DEPEND="virtual/x11"
RDEPEND=""

src_compile() {
	cd src
	for a in *.bdf; do
		cat < ${a} | ( rm ${a}; sed '/^FONT /s/\(.*-\)C*-/\1C-/' > ${a} )
	done

	# use built-in ucs2any
	PATH=".:${PATH}" ./compile || die "compile failed"
}

src_install() {
	dodoc doc/*
	cd lfp-fix
	insinto /usr/share/fonts/lfp-fix
	insopts -m0644
	doins * || die
}
