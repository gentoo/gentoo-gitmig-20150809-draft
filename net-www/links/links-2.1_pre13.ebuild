# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-2.1_pre13.ebuild,v 1.3 2003/12/21 00:34:18 gmsoft Exp $

IUSE="directfb ssl javascript png X gpm tiff fbcon svga jpeg"

DESCRIPTION="links is a fast lightweight text tand graphic web-browser"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~clock/twibright/links/"

# To handle pre-version ...
MYP="${P/_/}"
S="${WORKDIR}/${MYP}"
SRC_URI="${HOMEPAGE}/download/${MYP}.tar.bz2"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips hppa ~amd64"

# Note: if X or fbcon usegflag are enabled, links will be built in graphic
# mode. libpng is required to compile links in graphic mode
# (not required in text mode), so let's add libpng for X? and fbcon?

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6c )
	gpm? ( sys-libs/gpm )
	javascript? ( >=sys-devel/flex-2.5.4a )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.7 )
	svga? ( >=media-libs/svgalib-1.4.3 >=media-libs/libpng-1.2.1 )
	X? ( virtual/x11 >=media-libs/libpng-1.2.1 )
	directfb? ( dev-libs/DirectFB )
	fbcon? ( >=media-libs/libpng-1.2.1 sys-libs/gpm )"

PROVIDE="virtual/textbrowser"

pkg_setup (){

	if [ ! `use gpm` ] && [ `use fbcon` ] ; then
		einfo
		einfo "gpm has been installed since you have included fbcon in your USE flags."
		einfo "The links framebuffer driver requires gpm in order to compile."
		einfo
	fi

}

src_compile (){

	local myconf
	myconf="--program-suffix=2"

	use X \
		&& myconf="${myconf} --enable-graphics --with-x" \
		|| myconf="${myconf} --without-x"

	use png \
		&& myconf="${myconf} --with-libpng" \
		|| myconf="${myconf} --without-libpng"

	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"

	use tiff \
		&& myconf="${myconf} --with-libtiff" \
		|| myconf="${myconf} --without-libtiff"

	use svga \
		&& myconf="${myconf} --enable-graphics --with-svgalib" \
		|| myconf="${myconf} --without-svgalib"

	use fbcon \
		&& myconf="${myconf} --enable-graphics --with-fb" \
		|| myconf="${myconf} --without-fb"

	use directfb \
		&& myconf="${myconf} --enable-graphics --with-directfb" \
		|| myconf="${myconf} --without-directfb"

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use javascript \
		&& myconf="${myconf} --enable-javascript" \
		|| myconf="${myconf} --disable-javascript"

	# Note: --enable-static breaks.

	# Note: ./configure only support 'gpm' features auto-detection, so if
	# 'sys-libs/gpm' is compiled on your system, you'll compile links
	# with gpm support ...

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install (){
	einstall

	if [ ! -f /usr/bin/links ]
	then
		dosym links2 /usr/bin/links
	fi

	# Only install links icon if X driver was compiled in ...
	use X && { insinto /usr/share/pixmaps ;	doins graphics/links.xpm ; }

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README SITES TODO
	dohtml doc/links_cal/*
}


pkg_postinst() {

	if use svga
	then
		einfo "You had the svga USE flag enabled, but for security reasons"
		einfo "the links2 binary is NOT setuid by default. In order to"
		einfo "enable links2 to work in SVGA, please change the permissions"
		einfo "of /usr/bin/links2 to enable suid."
	fi
}
