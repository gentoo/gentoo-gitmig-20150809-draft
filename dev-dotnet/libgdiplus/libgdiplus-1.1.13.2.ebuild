# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.1.13.2.ebuild,v 1.4 2006/04/08 14:47:06 dertobi123 Exp $

inherit libtool eutils flag-o-matic toolchain-funcs

DESCRIPTION="Library for using System.Drawing with Mono"

HOMEPAGE="http://www.go-mono.com/"

SRC_URI="http://www.go-mono.com/sources/${PN}-${PV:0:3}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="tiff gif jpeg png"

RDEPEND="|| ( (	x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXt )
	virtual/x11 )
	dev-libs/glib
	media-libs/freetype
	media-libs/fontconfig
	tiff? ( media-libs/tiff )
	gif? ( >=media-libs/giflib-4.1.3 )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.13-libungif-configure-fix.diff
	libtoolize --copy --force || die "libtoolize failed"
	autoheader || die "autoheader failed"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	if [ "$(gcc-major-version)" -gt "3" ] || \
		( [ "$(gcc-major-version)" == "3" ] && \
			[ "$(gcc-minor-version)" -gt "3" ] )
	then
		append-flags -fno-inline-functions
	fi

	local myconf="--with-cairo=included --disable-glitz"
	use tiff ||  myconf="--without-libtiff ${myconf}"
	use gif ||  myconf="--without-libgif ${myconf}"
	use jpeg ||  myconf="--without-libjpeg ${myconf}"
	use png ||  myconf="--without-libpng ${myconf}"

	econf ${myconf} || die
	# attribute((__stdcall__)) generate warnings on ppc
	use ppc && sed -i -e 's:-Werror::g' src/Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
