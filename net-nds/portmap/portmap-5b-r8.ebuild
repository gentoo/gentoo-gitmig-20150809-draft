# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r8.ebuild,v 1.1 2003/12/26 23:50:58 azarah Exp $

inherit eutils

MY_P="${PN}_${PV}eta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc
	>=sys-apps/tcp-wrappers-7.6-r7"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}_5beta.dif

	# Redhat patches
	epatch ${FILESDIR}/${PN}-4.0-malloc.patch
	epatch ${FILESDIR}/${PN}-4.0-cleanup.patch
	epatch ${FILESDIR}/${PN}-4.0-rpc_user.patch
	epatch ${FILESDIR}/${PN}-4.0-sigpipe.patch

	# Should include errno.h, and not define as external.  Fix
	# relocation error and build problem with glibc-2.3.2 cvs ...
	# <azarah@gentoo.org> (31 Dec 2002).
	epatch ${FILESDIR}/${P}-include-errno_h.patch

	# Get portmap to use our CFLAGS ...
	sed -e "s:-O2:${CFLAGS}:" -i Makefile || die
}

src_compile() {
	make FACILITY=LOG_AUTH \
		ZOMBIES='-DIGNORE_SIGCHLD' \
		WRAP_DIR="${ROOT}/lib" \
		LIBS="-Wl,-Bstatic -lwrap -lutil -Wl,-Bdynamic -lnsl" \
		AUX= || die
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

