# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r6.ebuild,v 1.7 2002/09/14 15:51:24 bjb Exp $

MY_P=${PN}_${PV}eta
A0=portmap_5beta.dif
S=$WORKDIR/${MY_P}
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

DEPEND="virtual/glibc
		sys-apps/tcp-wrappers"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64 alpha"

src_unpack() {
	unpack ${A}
	cd $S || die
	patch -p0 < $FILESDIR/$A0 || die
	cp Makefile Makefile.orig
	sed -e "s/-O2/$CFLAGS/" Makefile.orig > Makefile || die
}

src_compile() {
	make || die
}

src_install() {
	into / ; dosbin portmap
	into /usr ; dosbin pmap_dump pmap_set
	doman portmap.8 pmap_dump.8 pmap_set.8

	exeinto /etc/init.d
	newexe ${FILESDIR}/portmap.rc6 portmap

	# is this really the sort of thing we wanna be doing? :)
	# ln -s ../../init.d/portmap $D/etc/runlevels/default/portmap

	dodoc BLURB CHANGES README
}
