# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.1.5.ebuild,v 1.2 2005/03/31 18:33:54 latexer Exp $

inherit libtool eutils

DESCRIPTION="Library for using System.Drawing with Mono"

HOMEPAGE="http://www.go-mono.com/"

SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="tiff gif jpeg png"

DEPEND="sys-devel/libtool
		sys-devel/automake
		sys-devel/autoconf
		>=x11-libs/cairo-0.3.0
		tiff? ( media-libs/tiff )
		gif? ( media-libs/giflib )
		jpeg? ( media-libs/jpeg )
		png? ( media-libs/libpng )"

RDEPEND=">=dev-lang/mono-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.4-included-cairo-fix.diff || die
	epatch ${FILESDIR}/${PN}-1.1.4-giflib.diff || die
	epatch ${FILESDIR}/${P}-nogif.diff || die
	libtoolize --copy --force || die "libtoolize failed"
	autoheader || die "autoheader failed"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	local myconf="--with-cairo=installed"
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
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README
}
