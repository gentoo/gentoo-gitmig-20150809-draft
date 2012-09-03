# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/girara/girara-0.1.4.ebuild,v 1.1 2012/09/03 18:34:51 ssuominen Exp $

EAPI=4
inherit multilib toolchain-funcs

DESCRIPTION="A library that implements a user interface that focuses on simplicity and minimalism"
HOMEPAGE="http://pwmt.org/projects/girara/"
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=x11-libs/gtk+-2.18.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	mygiraraconf=(
		LIBDIR='${PREFIX}'/$(get_libdir)
		GIRARA_GTK_VERSION=2
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# Remove 'static' and 'install-static' targets
	if ! use static-libs; then
		sed -i \
			-e '/^${PROJECT}:/s:static::' \
			-e '/^install:/s:install-static::' \
			Makefile || die
	fi
}

src_compile() {
	emake "${mygiraraconf[@]}"
}

src_install() {
	emake "${mygiraraconf[@]}" install
	dodoc AUTHORS
}
