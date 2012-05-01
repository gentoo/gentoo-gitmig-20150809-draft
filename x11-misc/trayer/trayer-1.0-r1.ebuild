# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/trayer/trayer-1.0-r1.ebuild,v 1.3 2012/05/01 20:55:58 jer Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Lightweight GTK+ based systray for UNIX desktop"
HOMEPAGE="http://fvwm-crystal.org"
SRC_URI="http://download.gna.org/fvwm-crystal/trayer/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libX11
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"

src_prepare() {
	# fix for as-needed, bug #141707
	# fix pre-stripped files, bug #252098
	sed -i Makefile \
		-e 's:$(LIBS) $(OBJ) $(SYSTRAYOBJ):$(OBJ) $(SYSTRAYOBJ) $(LIBS):' \
		-e 's:strip:true:g' \
		|| die
}

src_compile() {
	emake -j1 CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin trayer
	doman trayer.1
	dodoc CHANGELOG CREDITS README
}
