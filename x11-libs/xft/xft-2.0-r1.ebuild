# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xft/xft-2.0-r1.ebuild,v 1.1 2002/11/18 23:29:42 foser Exp $

PROVIDE="virtual/xft"
DESCRIPTION="Xft2"
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\./_}.tar.gz"     
HOMEPAGE="http://fontconfig.org/" 
LICENSE="fontconfig"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-base/xfree
	media-libs/fontconfig"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53a"	

S="${WORKDIR}/fcpackage.${PV/\./_}/Xft"   

src_unpack() {
	unpack ${A}
	
	cd ${S}
	export WANT_AUTOCONF_2_5=1
	autoconf --force
}

src_compile() {
	econf || die "Xft2 config failed"
	emake || die "Xft2 make failed"  
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share \
		libdir=${D}/usr/lib || die

	dodir /usr/X11R6/lib
	dosym /usr/lib/libXft.so.2.0 /usr/X11R6/lib/libXft.so     
}

pkg_preinst() {
	mv /usr/X11R6/include/X11/Xft /root/.Xft	
}

pkg_postinst() {
	einfo "Your old Xft includes have been saved to /root/.Xft"
}
