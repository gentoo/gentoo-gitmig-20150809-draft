# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shinonome/shinonome-0.9.8.ebuild,v 1.1 2002/08/22 15:34:03 stubear Exp $

DESCRIPTION="Japanese bitmap fonts for X"
SRC_URI="http://openlab.jp/efont/dist/shinonome/${P}-src.tar.bz2"
HOMEPAGE="http://openlab.jp/efont/shinonome/"
LICENSE="Public Domain"
SLOT=0
KEYWORDS="x86"

DEPEND="virtual/glibc virtual/x11 sys-devel/perl sys-apps/gawk"
RDEPEND="${DEPEND}"

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
