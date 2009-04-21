# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/bareftp/bareftp-0.2.2.ebuild,v 1.1 2009/04/21 14:52:50 loki_val Exp $

EAPI=2

inherit mono eutils autotools gnome2

DESCRIPTION="Mono based file transfer client"
HOMEPAGE="http://www.bareftp.org/"
SRC_URI="http://www.bareftp.org/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gtk-sharp-2.12
	>=dev-dotnet/gnome-sharp-2.20
	>=dev-dotnet/gnomevfs-sharp-2.20
	>=dev-dotnet/gconf-sharp-2.20"
DEPEND="${DEPEND}"

pkg_setup() {
	G2CONF="--disable-caches"
}

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}/${PN}-0.2.2-script.patch"
	eautoreconf
}

src_install() {
	gnome2_src_install
	dodoc ChangeLog README || die "dodoc failed"
}
