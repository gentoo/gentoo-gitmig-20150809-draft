# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.13.ebuild,v 1.3 2009/02/09 22:17:19 maekke Exp $

EAPI=2

inherit mono multilib eutils

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/gecko-sharp2/${PN}-2.0-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

S="${WORKDIR}/${PN}-2.0-${PV}"

RDEPEND=">=dev-lang/mono-1.2
	>=dev-dotnet/gtk-sharp-2
	>=net-libs/xulrunner-1.9"

DEPEND="${RDEPEND}
	doc? ( >=virtual/monodoc-1.0 )
	>=dev-util/pkgconfig-0.19"

src_prepare() {
	epatch "${FILESDIR}/${P}-xulrunner.patch"
}

src_configure() {
	export GACUTIL_FLAGS="-root ${D}/usr/$(get_libdir) -gacdir /usr/$(get_libdir) -package ${PN}-${SLOT}"

	econf --with-mozilla-libs="$(pkg-config --variable=sdkdir libxul)" --with-mozilla-header="$(pkg-config --variable=includedir libxul)"   || die "configure failed"
}
src_compile() {
		emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
