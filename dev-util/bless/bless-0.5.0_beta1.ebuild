# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.5.0_beta1.ebuild,v 1.1 2006/12/31 07:11:13 compnerd Exp $

inherit autotools eutils gnome2 mono

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-1.1.10
		 >=dev-dotnet/gtk-sharp-2.4
		 >=dev-dotnet/glade-sharp-2.4"
DEPEND="${RDEPEND}
		>=sys-devel/gettext-0.15
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

S="${WORKDIR}/${P/_/}"

pkg_setup() {
	G2CONF="${G2CONF} --enable-unix-specific $(use_enable debug)"
}

src_unpack() {
	gnome2_src_unpack
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.5.0-beta1-install.patch
	eautomake
}
