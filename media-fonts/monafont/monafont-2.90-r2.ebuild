# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.90-r2.ebuild,v 1.8 2006/10/23 19:08:21 corsair Exp $

inherit font

MY_P="${P/_/}"

DESCRIPTION="Japanese bitmap and TrueType fonts suitable for browsing 2ch"
HOMEPAGE="http://monafont.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
		truetype? ( mirror://sourceforge/${PN}/${PN}-ttf-${PV}.zip )"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ppc ppc64 s390 sh sparc ~x86"
IUSE="truetype"

DEPEND="|| ( ( x11-apps/bdftopcf x11-apps/mkfontdir ) <virtual/x11-7 )
		dev-lang/perl
		>=sys-apps/sed-4
		app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONTDIR="/usr/share/fonts/${PN}"

src_unpack() {
	unpack ${A}
	sed -i -e 's:$(X11BINDIR)/mkdirhier:/bin/mkdir -p:' ${S}/Makefile
}

src_compile() {
	PERL_BADLANG=0 ; LC_CTYPE=C
	export PERL_BADLANG LC_CTYPE
	emake X11BINDIR="/usr/bin" || die
}

src_install() {
	make install X11BINDIR="/usr/bin" X11FONTDIR="${D}/${FONTDIR}" || die
	mkfontdir "${D}/${FONTDIR}"
	insinto "${FONTDIR}"
	newins fonts.alias.mona fonts.alias
	dodoc README*

	if use truetype ; then
		DOCS="${WORKDIR}/README-ttf.txt"
		font_src_install
	fi
}

pkg_postinst() {
	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\tFontPath \"${FONTDIR}\""
	einfo
}

pkg_postrm() {
	einfo
	einfo "You need to remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\tFontPath \"${FONTDIR}\""
	einfo
}
