# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>

S=${WORKDIR}/${P}
DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="http://prdownloads.sourceforge.net/pcmcia-cs/${P}.tar.gz"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"


src_compile() {

	./Configure -n --target=${D}
	try emake all
}

src_install () {

	try make install
	rm ${D}/etc/rc.d/rc.pcmcia

	insinto /etc/rc.d/init.d
	insopts -m 0755
	doins ${FILESDIR}/pcmcia

	dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README README-2.4 \
	SUPPORTED.CARDS doc/*
}

