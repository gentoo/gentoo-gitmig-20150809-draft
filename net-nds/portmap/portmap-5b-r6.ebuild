# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r6.ebuild,v 1.16 2004/03/07 10:40:57 kumba Exp $

inherit eutils

MY_P=${PN}_${PV}eta
A0=portmap_5beta.dif
S=$WORKDIR/${MY_P}
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips amd64"

DEPEND="sys-apps/tcp-wrappers"

src_unpack() {
	unpack ${A}
	cd $S || die
	epatch $FILESDIR/$A0
	mv Makefile Makefile.orig || die
	sed -e "s:-O2:$CFLAGS:" Makefile.orig > Makefile || die
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
