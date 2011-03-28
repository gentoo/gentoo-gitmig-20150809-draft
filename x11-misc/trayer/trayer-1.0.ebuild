# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/trayer/trayer-1.0.ebuild,v 1.18 2011/03/28 14:34:48 nirbheek Exp $

EAPI="1"

DESCRIPTION="Lightweight GTK+ based systray for UNIX desktop"
HOMEPAGE="http://fvwm-crystal.org"
SRC_URI="http://download.gna.org/fvwm-crystal/trayer/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix for as-needed, bug #141707
	sed -i Makefile \
		-e 's/$(LIBS) $(OBJ) $(SYSTRAYOBJ)/$(OBJ) $(SYSTRAYOBJ) $(LIBS)/'
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	einstall PREFIX="${D}"/usr || die "einstall failed"
	dodoc CHANGELOG CREDITS README
}
