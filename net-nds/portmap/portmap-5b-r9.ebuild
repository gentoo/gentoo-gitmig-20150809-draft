# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r9.ebuild,v 1.4 2004/08/02 04:21:21 agriffis Exp $

inherit eutils

MY_P="${PN}_${PV}eta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Netkit - portmapper"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-*"
#KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/libc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r7 )"
RDEPEND="selinux? ( sec-policy/selinux-portmap )"
IUSE="tcpd selinux"

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
	local LIBS
	local WRAP_DIR
	local HOSTS_ACCESS
	# libutil static as per -r8
	#LIBS="-Wl,-Bstatic -lutil -Wl,-Bdynamic -lnsl"
	# libutil dynamic
	LIBS="-Wl,-Bdynamic -lutil -Wl,-Bdynamic -lnsl"
	WRAP_DIR=""
	HOSTS_ACCESS=""
	if use tcpd; then
	        WRAP_DIR="${ROOT}/usr/lib"
	        [ -f "${ROOT}/lib/libwrap.a" ] && WRAP_DIR="${ROOT}/lib"
			# static libwrap as per -r8
	        #LIBS="-Wl,-Bstatic -lwrap ${LIBS}"
			# libwrap dynamic
	        LIBS="-Wl,-Bdynamic -lwrap ${LIBS}"
	        HOSTS_ACCESS="-DHOSTS_ACCESS"
	else
	        sed -i -e "s:^WRAP_LIB:\#WRAP_LIB:" \
	        -e "s:^HOSTS_ACCESS:\#HOSTS_ACCESS:" \
	        -e 's:$(WRAP_DIR)/libwrap.a::g' \
	        Makefile
	fi

	make FACILITY=LOG_AUTH \
		ZOMBIES='-DIGNORE_SIGCHLD' \
		HOSTS_ACCESS="${HOSTS_ACCESS}" \
		WRAP_DIR="${WRAP_DIR}" \
		LIBS="${LIBS}" \
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

pkg_postinst() {
	enewgroup rpc 111
	enewuser rpc 111 /bin/false /dev/null rpc
}
