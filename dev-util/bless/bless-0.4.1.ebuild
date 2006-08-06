# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.4.1.ebuild,v 1.1 2006/08/06 18:21:28 compnerd Exp $

inherit mono eutils

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-1.1.10
		 >=dev-dotnet/gtk-sharp-2
		 >=dev-dotnet/glade-sharp-2"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) --enable-unix-specific --without-scrollkeeper \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
