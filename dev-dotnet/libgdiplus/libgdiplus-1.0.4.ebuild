# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.0.4.ebuild,v 1.1 2004/11/04 01:55:35 latexer Exp $

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
