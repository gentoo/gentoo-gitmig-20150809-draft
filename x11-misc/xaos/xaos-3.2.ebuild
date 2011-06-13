# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xaos/xaos-3.2.ebuild,v 1.8 2011/06/13 11:42:21 jlec Exp $

inherit eutils

MY_PN=XaoS
MY_P=${MY_PN}-${PV}

DESCRIPTION="A very fast real-time fractal zoomer"
HOMEPAGE="http://sourceforge.net/projects/xaos/"
SRC_URI="
	http://dev.gentoo.org/~jlec/distfiles/${PN}.png.tar
	mirror://sourceforge/xaos/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="X svga aalib nls"

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
	sys-libs/zlib
	media-libs/libpng"
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

S="${WORKDIR}"/${MY_P}

src_compile() {
	local myconf
	use X     || myconf="--with-x11-driver=no"
#	use dga   || myconf="${myconf} --with-dga-driver=no"
# ggi support removed due to upstream bug
	#use ggi   ||
	myconf="${myconf} --with-ggi-driver=no"
	use svga  || myconf="${myconf} --with-svga-driver=no"
#	use aalib || myconf="${myconf} --with-aa-driver=no"

	#i18n support is quite broken in XaoS, it gets installed
	#anyway, so we remove it later during install if not desired
	use nls   || myconf="${myconf} --with-i18n=no"

	./configure --prefix=/usr ${myconf} && make || die
}

src_install() {
	# these get installed, assuming that the directories exist!
	mkdir -p "${D}"/usr/share/locale/{hu,es,fr,cs,de}/LC_MESSAGES
	mkdir -p "${D}"/usr/share/{man,info}
	make \
		prefix="${D}"/usr \
		infodir="${D}"/usr/share/info \
		mandir="${D}"/usr/share/man \
		LOCALEDIR="${D}"/usr/share/locale \
	install || die

	use nls || rm -r "${D}"/usr/share/locale

	dodoc ChangeLog* INSTALL* TODO*
}
