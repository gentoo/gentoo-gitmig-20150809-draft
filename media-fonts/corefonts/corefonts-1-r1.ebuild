# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/corefonts/corefonts-1-r1.ebuild,v 1.7 2004/07/27 19:57:36 spyderous Exp $

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
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~ia64 amd64"
IUSE=""

DEPEND="app-arch/cabextract
	virtual/x11"

S=${WORKDIR}
FONTDIR="/usr/share/fonts/${PN}"

src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		cabextract --lowercase ${DISTDIR}/${exe} > /dev/null \
			|| die "failed to unpack ${exe}"
	done
}

src_install() {
	insinto ${FONTDIR}
	doins *.ttf || die

	/usr/X11R6/bin/mkfontscale ${D}${FONTDIR}
	/usr/X11R6/bin/mkfontdir ${D}${FONTDIR}
}

pkg_postinst() {

	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
	einfo "You also need to add the following line to /etc/fonts/local.conf"
	einfo
	einfo "\t <dir>${FONTDIR}</dir>"
	einfo
}

pkg_postrm(){

	einfo
	einfo "You need to remove following line from 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
	einfo "You also need to remove the following line from /etc/fonts/local.conf"
	einfo
	einfo "\t <dir>${FONTDIR}</dir>"
	einfo
}
