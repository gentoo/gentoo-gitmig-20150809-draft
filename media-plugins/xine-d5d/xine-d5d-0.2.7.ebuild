# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-d5d/xine-d5d-0.2.7.ebuild,v 1.2 2003/02/13 12:59:50 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Captain CSS menu plugin for the xine media player"
HOMEPAGE="http://members.fortunecity.de/captaincss/"
SRC_URI="http://members.fortunecity.de/captaincss/d5d${PV//./}.txt"

DEPEND="~media-libs/xine-lib-0.9.12"

SLOT="0"
LICENSE="LGPL"
KEYWORDS="x86 ppc"

src_unpack() {

        cp ${DISTDIR}/${A} . && chmod +x ${A} && ./${A} && \
        tar zxf ${WORKDIR}/${P}.tgz || \
        die "Unpacking failed"

}
src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
