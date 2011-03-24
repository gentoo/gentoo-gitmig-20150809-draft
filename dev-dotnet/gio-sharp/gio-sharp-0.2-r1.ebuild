# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gio-sharp/gio-sharp-0.2-r1.ebuild,v 1.2 2011/03/24 11:41:10 hwoarang Exp $

EAPI=2
inherit autotools eutils mono

DESCRIPTION="GIO API C# binding"
HOMEPAGE="http://github.com/mono/gio-sharp"
SRC_URI="http://github.com/mono/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=dev-dotnet/glib-sharp-2.12
	>=dev-dotnet/gtk-sharp-gapi-2.12
	>=dev-libs/glib-2.22:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-debug-libs.patch
	sed -i -e '/autoreconf/d' autogen-generic.sh || die
	NOCONFIGURE=1 ./autogen-2.22.sh || die

	eautoreconf
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README

	mono_multilib_comply
}
