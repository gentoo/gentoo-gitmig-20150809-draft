# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/galago-sharp/galago-sharp-0.5.0.ebuild,v 1.4 2006/12/19 22:38:57 compnerd Exp $

inherit eutils mono autotools

DESCRIPTION="Mono bindings to Galago"
HOMEPAGE="http://galago-project.org"
SRC_URI="http://galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.0
		 >=sys-apps/dbus-0.36
		 =dev-dotnet/gtk-sharp-2*
		 >=dev-libs/libgalago-0.5.0"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

pkg_setup() {
	if [[ -z $(best_version '>=sys-apps/dbus-0.90') ]] ; then
		if ! built_with_use 'sys-apps/dbus' mono ; then
			eerror "Please build dbus with mono support"
			die "dbus without mono support detected"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Hard enable/disable tests
	epatch ${FILESDIR}/${PN}-0.5.0-tests.patch

	eautoconf
	libtoolize --force --copy
}

src_compile() {
	econf --disable-tests || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
