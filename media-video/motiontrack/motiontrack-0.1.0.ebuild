# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motiontrack/motiontrack-0.1.0.ebuild,v 1.2 2004/07/23 16:09:38 squinky86 Exp $


DESCRIPTION="A set of tools that detect motion between two images"
SRC_URI="http://gemia.de/motion/${P}.tar.gz"
HOMEPAGE="http://motiontrack.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~ppc64 ~sparc ~mips ~alpha ~hppa ~amd64"

IUSE="libgd imagemagick debug"

DEPEND="virtual/libc
	debug? (
		libgd? (
			imagemagick?  ( >=media-gfx/imagemagick-5.5.7 ) : ( media-libs/gd )
		) : ( >=media-gfx/imagemagick-5.5.7 )
	) : (
		imagemagick? (
			gd? ( media-libs/gd ) : ( >=media-gfx/imagemagick-5.5.7 )
		) : ( media-libs/gd )
	)"

src_compile() {

	local myconf

	if use libgd; then
	 if use imagemagick; then
		einfo "motiontrack can only use one of libgd or imagemagick, not both."
		einfo "default is libgd when debug is unset, imagemagick otherwise."
		einfo "please unset one of these use flags if you have other intentions."
	 fi
	fi
	if use debug; then
		#default to imagemagick for providing better features
		#for debugging
		myconf="--enable-debug"
		if use libgd; then
			if use imagemagick; then
				myconf="${myconf} --enable-magick --disable-gd";
			else
				myconf="${myconf} --disable-magick --enable-gd";
			fi
		else
			myconf="${myconf} --enable-magick --disable-gd";
		fi
	else
		#default to libgd for being faster
		myconf="--disable-debug"
		if use imagemagick; then
			if use libgd; then
				myconf="${myconf} --disable-magick --enable-gd";
			else
				myconf="${myconf} --enable-magick --disable-gd";
		fi
		else
			myconf="${myconf} --disable-magick --enable-gd";
		fi
	fi

	econf $myconf || die "configure failed"
	emake || die "make failed"

}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README src/TheCode.txt
}


