# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/galago-sharp/galago-sharp-0.3.2.ebuild,v 1.1 2006/02/01 07:11:40 compnerd Exp $

inherit mono

DESCRIPTION="Mono bindings to Galago"
HOMEPAGE="http://galago-project.org"
SRC_URI="http://galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.9.6
		 >=dev-libs/libgalago-0.3.2"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
