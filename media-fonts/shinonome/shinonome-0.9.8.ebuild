# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/shinonome/shinonome-0.9.8.ebuild,v 1.5 2004/07/14 17:08:51 agriffis Exp $

DESCRIPTION="Japanese bitmap fonts for X"
SRC_URI="http://openlab.jp/efont/dist/shinonome/old/${P}-src.tar.bz2"
HOMEPAGE="http://openlab.jp/efont/shinonome/"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	dev-lang/perl
	sys-apps/gawk"
RDEPEND=""

S="${WORKDIR}/${P}-src"

src_compile(){
	# Install to /usr/X11R6/lib/X11/fonts/shinonome
	./configure \
		--with-fontdir=${D}/usr/X11R6/lib/X11/fonts/shinonome || die

	emake || die
}

src_install(){

	emake install       || die
	emake install-alias || die
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	echo -e "\n\t FontPath \"/usr/X11R6/lib/X11/fonts/shinonome\"\n\n"
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	echo -e "\n\t FontPath \"/usr/X11R6/lib/X11/fonts/shinonome\"\n\n"
}
