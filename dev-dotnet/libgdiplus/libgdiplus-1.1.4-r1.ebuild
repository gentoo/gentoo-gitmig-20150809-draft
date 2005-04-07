# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.1.4-r1.ebuild,v 1.1 2005/04/07 23:52:19 latexer Exp $

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
	epatch ${FILESDIR}/${P}-included-cairo-fix.diff || die
	epatch ${FILESDIR}/${P}-giflib.diff || die
	libtoolize --copy --force || die "libtoolize failed"
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
