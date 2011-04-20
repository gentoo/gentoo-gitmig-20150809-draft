# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tabbed/tabbed-0.3.ebuild,v 1.1 2011/04/20 14:23:46 jer Exp $

EAPI="3"

inherit savedconfig toolchain-funcs

DESCRIPTION="Simple generic tabbed fronted to xembed aware applications"
HOMEPAGE="http://tools.suckless.org/tabbed"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="
	x11-proto/xproto
	${RDEPEND}
"

src_prepare() {
	sed \
		-e 's|/usr/local|/usr|g' \
		-e 's|^CFLAGS.*|CFLAGS += -std=c99 -pedantic -Wall $(INCS) $(CPPFLAGS)|g' \
		-e 's|^LDFLAGS.*|LDFLAGS += $(LIBS)|g' \
		-e 's|^LIBS.*|LIBS = -lX11|g' \
		-e '/^CC/d' \
		-i config.mk || die
	sed \
		-e 's|{|(|g;s|}|)|g' \
		-i Makefile config.mk || die
	restore_config config.h
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake compile failed"
}
src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	save_config config.h
}
