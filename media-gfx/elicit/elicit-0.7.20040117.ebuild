# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/elicit/elicit-0.7.20040117.ebuild,v 1.1 2004/01/20 05:03:29 vapier Exp $

inherit enlightenment

DESCRIPTION="E17 theme maker"

DEPEND="${DEPEND}
	>=x11-libs/evas-1.0.0.20031018_pre12
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=media-libs/edje-0.0.1.20031018
	>=media-libs/imlib2-1.1.0"

src_unpack() {
	unpack ${A}
	sed -i 's:/usr/local:/usr:' ${S}/config.h
	sed -i "s: -g : ${CFLAGS} :" ${S}/src/Makefile
}

src_compile() {
	cd src
	emake || die
}

src_install() {
	dobin src/elicit
	dodir /usr/share/${PN}
	cp -r data ${D}/usr/share/${PN}/
	find ${D} -name CVS -type d -exec rm -rf '{}' \; 2>/dev/null
	dodoc README TODO
}
