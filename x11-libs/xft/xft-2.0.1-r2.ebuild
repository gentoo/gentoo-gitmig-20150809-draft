# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xft/xft-2.0.1-r2.ebuild,v 1.2 2003/04/15 02:34:20 seemant Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/fcpackage.${PV/\.0\./_}/Xft"
DESCRIPTION="X FreeType library, also known as Xft2.0"
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\.0\./_}.tar.gz"     
HOMEPAGE="http://fontconfig.org/"

LICENSE="fontconfig"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa arm"

RDEPEND="x11-base/xfree
	>=media-libs/fontconfig-2.1-r1"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53a"	

PROVIDE="virtual/xft"

src_unpack() {
	unpack ${A}
	
	cd ${S}

	# Update from XFree86 cvs tree
	epatch ${FILESDIR}/${P}-cvs-update-20021221.patch
	
	einfo "Running autoconf..."
	export WANT_AUTOCONF_2_5=1
	autoconf --force
}

src_compile() {
	econf --x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		--includedir=/usr/X11R6/include \
		|| die "Xft2 config failed"
	emake || die "Xft2 make failed"  
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share \
		includedir=${D}/usr/X11R6/include || die

	dodir /usr/X11R6/lib
	dosym ../../lib/libXft.so.2.0 /usr/X11R6/lib/libXft.so     
}

pkg_preinst() {
	if [ "${ROOT}" = "/" -a ! -d /root/.Xft -a \
	     -f /usr/X11R6/include/X11/Xft/XftFreetype.h ]
	then
		mv -f /usr/X11R6/include/X11/Xft /root/.Xft
	fi
}

pkg_postinst() {
	einfo "Your old Xft1.1 includes have been saved to /root/.Xft,"
	einfo "if they were present ..."
}

