# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r7.ebuild,v 1.14 2004/04/06 10:49:55 method Exp $

inherit eutils

IUSE="selinux"
MY_P=${PN}_${PV}eta
S=${WORKDIR}/${MY_P}
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64 ppc64"

DEPEND="virtual/glibc
	sys-apps/tcp-wrappers"

RDEPEND="selinux? ( sec-policy/selinux-portmap )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}_5beta.dif

	# Should include errno.h, and not define as external.  Fix
	# relocation error and build problem with glibc-2.3.2 cvs ...
	# <azarah@gentoo.org> (31 Dec 2002).
	epatch ${FILESDIR}/${P}-include-errno_h.patch

	# Get portmap to use our CFLAGS ...
	mv Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile || die
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

	# Is this really the sort of thing we wanna be doing? :)
	# ln -s ../../init.d/portmap ${D}/etc/runlevels/default/portmap

	dodoc BLURB CHANGES README
}
