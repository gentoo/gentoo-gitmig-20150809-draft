# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute2/iproute2-2.6.7.20040608-r1.ebuild,v 1.1 2004/09/13 09:17:17 solar Exp $

inherit eutils gcc

MY_PV="${PV:0:5}"
SNAP="${PV:${#PV}-6}"
DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="http://developer.osdl.org/dev/iproute2/"
SRC_URI="http://developer.osdl.org/dev/iproute2/download/${PN}-${MY_PV}-ss${SNAP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE="atm minimal"

RDEPEND="virtual/libc
	!minimal? ( sys-libs/db )
	atm? ( net-dialup/linux-atm )"
DEPEND="${RDEPEND}
	>=virtual/os-headers-2.4.21
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}-${MY_PV}

pkg_setup() {
	SUBDIRS="lib ip tc misc"
	use minimal && SUBDIRS="lib tc"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Enable HFSC scheduler #45274
	if [ ! -z "`grep tc_service_curve ${ROOT}/usr/include/linux/pkt_sched.h`" ] ; then
		epatch ${FILESDIR}/2.4.7.20020116-hfsc.patch
	else
		ewarn "Your linux-headers in /usr/include/linux are too old to"
		ewarn "support the HFSC scheduler.  It has been disabled."
		echo
	fi
	# Disable q_delay if need be
	if [ -z "`grep tc_dly_qopt ${ROOT}/usr/include/linux/pkt_sched.h`" ] ; then
		ewarn "Your linux-headers in /usr/include/linux are too old to"
		ewarn "support the DELAY scheduler.  It has been disabled."
		echo
		sed -i '/q_delay/s:.*::' tc/Makefile
	fi

	# Add a few debian fixes
	epatch ${FILESDIR}/${PV}-misc-deb-fixes.patch
	epatch ${FILESDIR}/${PV}-misc-gentoo-fixes.patch

	# Fix cflags and db code
	sed -i \
		-e 's:-I/usr/include/db3::g' \
		-e "s:-O2:${CFLAGS}:g" \
		Makefile || die "sed Makefile failed"
	sed -i 's:-ldb-4\.1:-ldb:' misc/Makefile || die "sed misc/Makefile failed"
	sed -i 's:db41/db_185:db_185:' misc/arpd.c || die "sed misc/arpd.c failed"

	# Enable diffserv/atm support
	if use atm ; then
		sed -i 's:=n$:=y:' Config || die "sed Config failed"
	fi
}

src_compile() {
	emake CC="$(gcc-getCC)" KERNEL_INCLUDE=${ROOT}/usr/include SUBDIRS="${SUBDIRS}" || die
}

src_install() {
	if use minimal; then
		into /
		dosbin tc/tc
		return 0
	fi
	make install DESTDIR=${D} DOCDIR=/usr/share/doc/${PF} || die "make install failed"

	into /
	dosbin ip/{ifcfg,rtpr} || die "dosbin failed"

	doman man/*/*
}
