# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cel-cvs/cel-cvs-0.97.ebuild,v 1.1 2003/04/03 14:13:57 malverian Exp $

HOMEPAGE="http://cel.sourceforge.net"
DESCRIPTION="A game entity layer based on Crystal Space"
LICENSE="LGPL-2"

SLOT=0

KEYWORDS="~x86"

DEPEND="crystalspace-cvs
		jam"

CEL_PREFIX=${CRYSTAL}

inherit cvs

ECVS_SERVER="cvs.cel.sourceforge.net:/cvsroot/cel"
ECVS_MODULE="cel"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}


src_compile() {
	./autogen.sh || die
	./configure --prefix=${CEL_PREFIX} || die
	jam || die
}

src_install() {
	sed -i -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex

	for a in `find include -iname "*.h"`; do
		install -m 644 -D ${a} ${D}/${CEL_PREFIX}/${a};
	done

	install -d ${D}/${CEL_PREFIX}/lib
	install -c *.so ${D}/${CEL_PREFIX}/lib

	install -D celtst ${D}/${CRYSTAL}/bin/celtst
	install -c -m 644 cel.cex ${D}/${CRYSTAL}/bin/cel.cex
}
