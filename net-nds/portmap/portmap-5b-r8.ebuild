# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-5b-r8.ebuild,v 1.17 2004/10/31 05:58:05 vapier Exp $

inherit eutils

MY_P="${PN}_${PV}eta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Netkit - portmapper"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI="ftp://ftp.porcupine.org/pub/security/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="selinux"

DEPEND="virtual/libc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r7 )
	>=sys-apps/portage-2.0.51"
RDEPEND="selinux? ( sec-policy/selinux-portmap )"

pkg_setup() {
	enewgroup rpc 111
	enewuser rpc 111 /bin/false /dev/null rpc
}

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
	local WRAP_DIR="${ROOT}/usr/lib"

	[ -f "${ROOT}/lib/libwrap.a" ] && WRAP_DIR="${ROOT}/lib"

	make FACILITY=LOG_AUTH \
		ZOMBIES='-DIGNORE_SIGCHLD' \
		WRAP_DIR="${WRAP_DIR}" \
		LIBS="-Wl,-Bstatic -lwrap -lutil -Wl,-Bdynamic -lnsl" \
		AUX= || die
}

src_install() {
	into /
	dosbin portmap || die "portmap"
	into /usr
	dosbin pmap_dump pmap_set || die "pmap"

	doman portmap.8 pmap_dump.8 pmap_set.8
	dodoc BLURB CHANGES README
	newinitd ${FILESDIR}/portmap.rc6 portmap
}
