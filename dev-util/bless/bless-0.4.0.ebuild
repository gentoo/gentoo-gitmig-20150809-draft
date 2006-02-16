# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.4.0.ebuild,v 1.2 2006/02/16 21:39:25 swegener Exp $

inherit mono

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.4
		 >=dev-dotnet/gtk-sharp-2
		 >=dev-dotnet/glade-sharp-2"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	econf --enable-unix-specific --without-scrollkeeper || die "conf failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog README
}
