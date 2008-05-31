# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-addins/mono-addins-0.2.ebuild,v 1.4 2008/05/31 12:36:07 jurek Exp $

inherit eutils mono

DESCRIPTION="A generic framework for creating extensible applications"
HOMEPAGE="http://www.mono-project.com/Mono.Addins"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="X"

DEPEND=">=dev-lang/mono-1.2
		X? ( >=dev-dotnet/gtk-sharp-2.0
			>=dev-dotnet/gnome-sharp-2.0
			>=dev-dotnet/glade-sharp-2.0 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-disable-gui.patch"
}

src_compile() {
	econf \
		--disable-tests \
		$(use_enable X gui) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
