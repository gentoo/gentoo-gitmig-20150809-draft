# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/bareftp/bareftp-0.3.7.ebuild,v 1.3 2011/01/29 17:07:45 hwoarang Exp $

EAPI=2

inherit mono gnome2

DESCRIPTION="Mono based file transfer client"
HOMEPAGE="http://www.bareftp.org/"
SRC_URI="http://www.bareftp.org/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome-keyring"

RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gtk-sharp-2.12
	>=dev-dotnet/gnome-sharp-2.20
	>=dev-dotnet/gnomevfs-sharp-2.20
	>=dev-dotnet/gconf-sharp-2.20
	gnome-keyring? ( >=dev-dotnet/gnome-keyring-sharp-1.0.0-r2 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	G2CONF="--disable-caches
		$(use_with gnome-keyring gnomekeyring)"
}

src_install() {
	gnome2_src_install
	dodoc ChangeLog README || die "dodoc failed"
}
