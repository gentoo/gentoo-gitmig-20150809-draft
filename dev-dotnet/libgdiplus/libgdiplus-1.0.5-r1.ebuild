# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.0.5-r1.ebuild,v 1.1 2005/01/25 16:39:11 latexer Exp $

inherit libtool

DESCRIPTION="Library for using System.Drawing with Mono"

HOMEPAGE="http://www.go-mono.com/"

SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="tiff gif jpeg png"

DEPEND="sys-devel/libtool
		>=x11-libs/cairo-0.1.23
		tiff? ( media-libs/tiff )
		gif? ( media-libs/libungif )
		jpeg? ( media-libs/jpeg )
		png? ( media-libs/libpng )"

RDEPEND=">=dev-dotnet/mono-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# See bug #55916
	einfo "Fixing a libtool problem"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	libtoolize --force --copy || die "libtoolize failed"
}

src_compile() {
	local myconf=""
	use tiff ||  myconf="--without-libtiff ${myconf}"
	use gif ||  myconf="--without-libungif ${myconf}"
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
