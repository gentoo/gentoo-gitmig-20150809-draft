# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xft/xft-2.0.1.ebuild,v 1.4 2003/03/11 11:07:50 gmsoft Exp $

IUSE=""

S="${WORKDIR}/fcpackage.${PV/\.0\./_}/Xft"
PROVIDE="virtual/xft"
DESCRIPTION="X FreeType library, also known as Xft2.0"
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\.0\./_}.tar.gz"     
HOMEPAGE="http://fontconfig.org/"

LICENSE="fontconfig"
SLOT="0"
KEYWORDS="x86 ~ppc hppa"

RDEPEND="x11-base/xfree
	>=media-libs/fontconfig-2.1"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53a"	

src_unpack() {
	unpack ${A}
	
	cd ${S}
	export WANT_AUTOCONF_2_5=1
	autoconf --force
}

src_compile() {
	econf --x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		|| die "Xft2 config failed"
	emake || die "Xft2 make failed"  
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share || die

	dodir /usr/X11R6/lib
	dosym ../../lib/libXft.so.2.0 /usr/X11R6/lib/libXft.so     
}

pkg_preinst() {
	if [ "${ROOT}" = "/" -a ! -d /root/.Xft ]
	then
		mv -f /usr/X11R6/include/X11/Xft /root/.Xft
	fi
}

pkg_postinst() {
	einfo "Your old Xft includes have been saved to /root/.Xft"
}
