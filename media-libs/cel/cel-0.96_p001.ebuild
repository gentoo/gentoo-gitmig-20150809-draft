# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cel/cel-0.96_p001.ebuild,v 1.1 2003/04/02 19:11:02 malverian Exp $

SRC_URI="http://telia.dl.sourceforge.net/sourceforge/cel/cel_0.96r001.tar.bz2"
HOMEPAGE="http://cel.sf.net"
DESCRIPTION="A game entity layer based on Crystal Space"
LICENSE="LGPL-2"

SLOT=0

KEYWORDS="~x86"

DEPEND="crystalspace
		jam"

RDEPEND=${DEPEND}

S=${WORKDIR}/${PN}

src_compile() {
	./autogen.sh || die
	./configure --prefix=${CRYSTAL}/cel || die
	jam || die
}

src_install() {
	sed -i -e "s:/usr/local/cel:${CRYSTAL}/cel:g" cel.cex

	for a in `find include -iname "*.h"`;
		do chmod a-x ${a};
		install -D ${a} ${D}/${CRYSTAL}/cel/${a};
	done

	install -d ${D}/${CRYSTAL}/cel/lib
	install -c *.so ${D}/${CRYSTAL}/cel/lib

	install -D celtst ${D}/${CRYSTAL}/bin/celtst
	install -c cel.cex ${D}/${CRYSTAL}/bin/cel.cex
}
