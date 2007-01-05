# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.90-r1.ebuild,v 1.12 2007/01/05 17:08:16 flameeyes Exp $

inherit font

MY_P=${P/_/}

DESCRIPTION="Japanese bitmap and TrueType fonts suitable for browsing 2ch"
HOMEPAGE="http://monafont.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	truetype? ( mirror://sourceforge/${PN}/${PN}-ttf-${PV}.zip )"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="X truetype"

RDEPEND=""
DEPEND="${RDEPEND}
	|| ( x11-apps/bdftopcf virtual/x11 )
	dev-lang/perl
	>=sys-apps/sed-4
	app-arch/unzip"

S="${WORKDIR}/${MY_P}"
FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONTDIR=/usr/share/fonts/${PN}

src_unpack() {
	unpack ${A}
	sed -i -e 's:$(X11BINDIR)/mkdirhier:/bin/mkdir -p:' ${S}/Makefile
}

src_compile() {
	PERL_BADLANG=0 ; LC_CTYPE=C
	export PERL_BADLANG LC_CTYPE
	emake || die
}

src_install() {
	make install X11FONTDIR=${D}/${FONTDIR} || die
	mkfontdir ${D}/${FONTDIR}
	insinto ${FONTDIR}
	newins fonts.alias.mona fonts.alias
	dodoc README*

	if use truetype ; then
		DOCS=${WORKDIR}/README-ttf.txt
		font_src_install
	fi
}

pkg_postinst() {
	elog
	elog "You need to add following line into 'Section \"Files\"' in"
	elog "XF86Config and reboot X Window System, to use these fonts."
	elog
	elog "\tFontPath \"${FONTDIR}\""
	elog
}

pkg_postrm() {
	elog
	elog "You need to remove following line in 'Section \"Files\"' in"
	elog "XF86Config, to unmerge this package completely."
	elog
	elog "\tFontPath \"${FONTDIR}\""
	elog
}
