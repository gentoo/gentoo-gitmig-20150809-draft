# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-2.1_pre2-r1.ebuild,v 1.2 2002/07/16 04:54:33 seemant Exp $

DESCRIPTION="links is a fast lightweight text tand graphic web-browser"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~clock/twibright/links/"

# To handle pre-version ...
MYP="${P/_/}"
S="${WORKDIR}/${MYP}"
SRC_URI="${HOMEPAGE}/download/${MYP}.tar.bz2
	http://www.ibiblio.org/gentoo/distfiles/links-2.1_pre2-patch.tar.bz2"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6c )
	gpm? ( sys-libs/gpm )
	java? ( >=sys-devel/flex-2.5.4a )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.7 )
	svga? ( >=media-libs/svgalib-1.4.3 )
	X? ( virtual/x11 )"

src_compile ()
{
	local myconf

	myconf="--program-suffix=2"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use png \
		&& myconf="${myconf} --enable-graphics --with-libpng" \
		|| myconf="${myconf} --disable-graphics --without-libpng"

	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"

	use tiff \
		&& myconf="${myconf} --with-libtiff" \
		|| myconf="${myconf} --without-libtiff"

	use svga \
		&& myconf="${myconf} --with-svgalib" \
		|| myconf="${myconf} --without-svgalib"

	use fbcon \
		&& myconf="${myconf} --with-fb" \
		|| myconf="${myconf} --without-fb"

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use java \
		&& myconf="${myconf} --enable-javascript" \
		|| myconf="${myconf} --disable-javascript"

	# ./configure only support 'gpm' features auto-detection, so if
	# 'sys-libs/gpm' is compiled on your system, you'll compile links
	# with gpm support ...
	# This patch adds support for various little fix's
	patch -p1 < ${WORKDIR}/links.patch || die

	econf ${myconf} || die
	emake || die "make failed"
}

src_install ()
{
	einstall || die "make install failed"

	# Only install links icon if X driver was compiled in ...
	use X && ( \
		insinto /usr/share/pixmaps
		doins graphics/links.xpm
	)
	
	
	# links needs to be setuid for it to work with svga
	use svga && ( \
		fperms 4755 /usr/bin/links
	)
	
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README SITES TODO
	dohtml doc/links_cal/*
}
