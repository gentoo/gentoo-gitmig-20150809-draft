# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iconbar/iconbar-0.5.20031225.ebuild,v 1.1 2003/12/25 05:56:45 vapier Exp $

inherit enlightenment

DESCRIPTION="e17 iconbar as a standalone package"
HOMEPAGE="http://www.rephorm.com/rephorm/code/iconbar/"

DEPEND=">=dev-libs/eet-0.9.0.20031013
	>=x11-libs/evas-1.0.0.20031013_pre12
	>=media-libs/imlib2-1.1.0
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=media-libs/edje-0.0.1.20031013"

src_unpack() {
	unpack ${A}
	sed -i 's: -g : :' ${S}/src/Makefile
}

src_compile() {
	emake CC="gcc ${CFLAGS}" PREFIX=/usr || die
}

src_install() {
	dodir /usr/share/iconbar /usr/bin
	make install PREFIX=${D}/usr || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
}
