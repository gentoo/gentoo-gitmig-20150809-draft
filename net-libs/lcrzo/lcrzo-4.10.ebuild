# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/lcrzo/lcrzo-4.10.ebuild,v 1.2 2002/07/17 06:28:53 seemant Exp $

S=${WORKDIR}/${P}-src
DESCRIPTION="Library of Ethernet, IP, UDP, TCP, ICMP, ARP and RARP protocols"
HOMEPAGE="http://www.laurentconstantin.com/en/lcrzo/"
SRC_URI="http://www.laurentconstantin.com/common/${PN}/download/v4/${P}-src.tgz"

DEPEND="virtual/glibc net-libs/libpcap"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A} ; cd ${S}/src

	# genemake checks that these directories exist...
	mv genemake genemake.orig
	sed -e "s:/usr/local/include:/usr/include:" \
		-e "s:/usr/local/lib:/usr/lib:" \
		-e "s:/usr/local/bin:/usr/bin:" \
		-e "s:/usr/local/man/man1:/usr/share/man/man1:" \
		-e "s:/usr/local/man/man3:/usr/share/man/man3:" \
		genemake.orig > genemake

	chmod 755 genemake
	./genemake || die "problem creating Makefile"

	# plug in our CFLAGS and make it install into ${D}...
	mv Makefile Makefile.orig
	sed -e "s:^\(GCCOPT=\).*:\1${CFLAGS}:" \
		-e "s:^\(GCCOPTL=\).*:\1${CFLAGS}:" \
		-e "s:^\(GCCOPTP=\).*:\1${CFLAGS}:" \
		-e "s:^\(INSTINCLUDE=\):\1${D}:" \
		-e "s:^\(INSTLIB=\):\1${D}:" \
		-e "s:^\(INSTBIN=\):\1${D}:" \
		-e "s:^\(INSTMAN1=\):\1${D}:" \
		-e "s:^\(INSTMAN3=\):\1${D}:" \
		Makefile.orig > Makefile
}

src_compile() {
	make -C src || die "compile problem"
}

src_install() {
	dodir /usr/{bin,include,lib} /usr/share/man/{man1,man3}
	make -C src install || die
	dodoc doc/*.txt
}
