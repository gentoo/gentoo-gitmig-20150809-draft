# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/jumanji/jumanji-9999.ebuild,v 1.2 2010/08/24 22:53:34 xmw Exp $

EAPI=2

inherit flag-o-matic git toolchain-funcs

DESCRIPTION="webkit based browser"
HOMEPAGE="http://pwmt.org/projects/jumanji"
SRC_URI=""
EGIT_REPO_URI="git://pwmt.org/jumanji.git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-libs/glib-2.22.4:2
	>=dev-libs/libunique-1.1.6:0
	>=net-libs/libsoup-2.30.2:2.4
	>=net-libs/webkit-gtk-1.2.1
	>=x11-libs/gtk+-2.18.6:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	git_src_prepare
	# respect CFLAGS
	sed -i -e '/${CC}/s:${CFLAGS}:\0 ${INCS}:' Makefile || die
}

src_compile() {
	tc-export CC
	append-cflags -std=c99
	emake CFLAGS="${CFLAGS}" DFLAGS="" SFLAGS="" all || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
