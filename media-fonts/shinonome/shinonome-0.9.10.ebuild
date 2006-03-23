# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/shinonome/shinonome-0.9.10.ebuild,v 1.9 2006/03/23 21:11:04 spyderous Exp $

IUSE=""

DESCRIPTION="Japanese bitmap fonts for X"
SRC_URI="http://openlab.jp/efont/dist/shinonome/${P}.tar.bz2"
HOMEPAGE="http://openlab.jp/efont/shinonome/"

LICENSE="public-domain"
SLOT=0
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="virtual/libc
	|| ( ( x11-apps/bdftopcf
			x11-apps/mkfontdir
		)
		virtual/x11
	)
	dev-lang/perl
	sys-apps/gawk"
RDEPEND=""

FONTDIR="/usr/share/fonts/shinonome"

src_compile(){
	econf --with-pcf --without-bdf --enable-compress=gzip \
		--with-fontdir=${D}/${FONTDIR} || die

	emake || die
}

src_install(){
	emake install       || die
	emake install-alias || die

	dodoc AUTHORS BUGS ChangeLog* DESIGN* INSTALL LICENSE README THANKS TODO
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}\""
	einfo ""
}
