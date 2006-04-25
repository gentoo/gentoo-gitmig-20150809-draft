# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/galago-sharp/galago-sharp-0.3.2.ebuild,v 1.5 2006/04/25 14:50:36 dertobi123 Exp $

inherit eutils mono

DESCRIPTION="Mono bindings to Galago"
HOMEPAGE="http://galago-project.org"
SRC_URI="http://galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.9.6
		 >=sys-apps/dbus-0.3.5
		 >=dev-libs/libgalago-0.3.2"
DEPEND="${RDEPEND}
		 =dev-dotnet/gtk-sharp-1.0*
		>=dev-util/pkgconfig-0.9"

pkg_setup() {
	if ! built_with_use 'sys-apps/dbus' mono ; then
		eerror "Please build dbus with mono support"
		die "dbus without mono support detected"
	fi
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
