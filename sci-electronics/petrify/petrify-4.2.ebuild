# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/petrify/petrify-4.2.ebuild,v 1.3 2005/08/23 20:46:29 chrb Exp $

DESCRIPTION="Synthesize Petri nets into asynchronous circuits"
HOMEPAGE="http://www.lsi.upc.es/~jordic/petrify/"
SRC_URI="http://www.lsi.upc.es/~jordic/petrify/distrib/petrify-4.2-linux.tgz"
LICENSE="petrify"
KEYWORDS="~x86"
RESTRICT="nostrip"
RDEPEND="media-gfx/graphviz"
SLOT="0"
IUSE=""

src_install () {
	cd ${WORKDIR}/petrify
	dodir /opt/petrify
	exeinto /opt/petrify
	doexe bin/petrify
	dosym /opt/petrify/petrify /opt/petrify/draw_astg
	dosym /opt/petrify/petrify /opt/petrify/write_sg
	dodoc doc/*
	doman man/man1/*
	cp -pPR lib/petrify.lib ${D}/opt/petrify
	dodir /etc/env.d
	echo "PATH=/opt/petrify" > ${D}/etc/env.d/00petrify
}
