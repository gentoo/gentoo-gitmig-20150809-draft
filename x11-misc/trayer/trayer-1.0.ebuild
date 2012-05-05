# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/trayer/trayer-1.0.ebuild,v 1.20 2012/05/05 04:53:44 jdhore Exp $

EAPI="1"

DESCRIPTION="Lightweight GTK+ based systray for UNIX desktop"
HOMEPAGE="http://home.gna.org/fvwm-crystal/"
SRC_URI="http://download.gna.org/fvwm-crystal/trayer/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

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
