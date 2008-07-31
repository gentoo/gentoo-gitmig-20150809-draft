# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xaos/xaos-3.4.ebuild,v 1.2 2008/07/31 22:36:54 markusle Exp $

IUSE="aalib nls png svga threads X"

MY_PN=XaoS
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A very fast real-time fractal zoomer"
HOMEPAGE="http://xaos.sf.net/"
SRC_URI="mirror://sourceforge/xaos/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="X? (
				(
				x11-libs/libX11
				x11-libs/libXxf86dga
				x11-libs/libXext
				x11-libs/libXxf86vm
				)
		   )
	svga? ( >=media-libs/svgalib-1.4.3 )
	aalib? ( media-libs/aalib )
	png? ( media-libs/libpng )
	sys-libs/zlib
	sci-libs/gsl"
# xaos has ggi support, but it doesn't build
#	ggi?   ( media-libs/libggi )

DEPEND="${RDEPEND}
		X? (
				(
				x11-proto/xf86vidmodeproto
				x11-proto/xextproto
				x11-proto/xf86dgaproto
				x11-proto/xproto
				)
			)"

src_compile() {
	local myconf="--with-sffe=yes --with-ggi-driver=no"

	# make sure we use gsl and not nasm (see bug #233318)
	myconf="${myconf} --with-i386asm=no --with-gsl=yes"

	econf \
		$(use_with png) \
		$(use_with aalib aa-driver) \
		$(use_with svga svga-driver) \
		$(use_with threads pthread) \
		$(use_with X x11-driver) \
		$(use_with X x) \
		$(use_enable nls) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog* TODO RELEASE_NOTES README
}
