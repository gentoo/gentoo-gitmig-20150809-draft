# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0.1.ebuild,v 1.8 2004/10/26 14:16:15 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"

LICENSE="isc-dhcp"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~mips ppc ~ppc64 sparc x86"
IUSE="static selinux"

RDEPEND="virtual/libc
	selinux? ( sec-policy/selinux-dhcp )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dhcp-3.0+paranoia.patch
	epatch ${FILESDIR}/dhcp-3.0pl2-fix-perms.patch
	has noman ${FEATURES} && sed -i 's:nroff:echo:' */Makefile.dist
}

src_compile() {
	# 01/Mar/2003: Fix for bug #11960 by Jason Wever <weeve@gentoo.org>
	[ "${ARCH}" == "sparc" ] && filter-flags -O3 -O2 -O

	use static && append-flags -static

	cat <<-END >> includes/site.h
	#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
	#define _PATH_DHCPD_PID "/var/run/dhcp/dhcpd.pid"
	#define _PATH_DHCPD_DB "/var/lib/dhcp/dhcpd.leases"
	#define _PATH_DHCLIENT_DB "/var/lib/dhcp/dhclient.leases"
	#define DHCPD_LOG_FACILITY LOG_LOCAL1
	END

	cat <<-END > site.conf
	CC = $(tc-getCC)
	LIBDIR = /usr/lib
	INCDIR = /usr/include
	ETC = /etc/dhcp
	VARDB = /var/lib/dhcp
	VARRUN = /var/run/dhcp
	ADMMANDIR = /usr/share/man/man8
	FFMANDIR = /usr/share/man/man5
	LIBMANDIR = /usr/share/man/man3
	USRMANDIR = /usr/share/man/man1
	END

	./configure \
		--copts "-DPARANOIA -DEARLY_CHROOT ${CFLAGS}" \
		|| die "configure failed"

	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die

	insinto /etc/dhcp
	newins server/dhcpd.conf dhcpd.conf.sample
	newins client/dhclient.conf dhclient.conf.sample
	dosed "s:/etc/dhclient-script:/etc/dhcp/dhclient-script:" \
		/etc/dhcp/dhclient.conf.sample
	mv "${D}/sbin/dhclient-script" "${D}/etc/dhcp/dhclient-script.sample"

	dodoc ANONCVS CHANGES README RELNOTES doc/*
	newdoc client/dhclient.conf dhclient.conf.sample
	newdoc client/scripts/linux dhclient-script.sample
	newdoc server/dhcpd.conf dhcpd.conf.sample

	exeinto /etc/init.d
	newexe "${FILESDIR}/dhcp.rc6" dhcp
	newexe "${FILESDIR}/dhcrelay.rc6" dhcrelay
	insinto /etc/conf.d
	newins "${FILESDIR}/dhcp.conf" dhcp
	newins "${FILESDIR}/dhcrelay.conf" dhcrelay

	keepdir /var/{lib,run}/dhcp
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 /bin/false /var/lib/dhcp dhcp
}

pkg_postinst() {
	chown dhcp:dhcp "${ROOT}/var/lib/dhcp" "${ROOT}/var/run/dhcp"

	einfo "You can edit /etc/conf.d/dhcp to customize dhcp settings"
	einfo
	einfo "The DHCP ebuild now includes chroot support."
	einfo "If you like to run dhcpd in chroot AND this is a new install OR"
	einfo "your dhcpd doesn't already run in chroot, simply run:"
	einfo "  ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "Before running the above command you might want to change the chroot"
	einfo "dir in /etc/conf.d/dhcp, otherwise /chroot/dhcp will be used."
	echo
}

pkg_config() {
	CHROOT=`sed -n 's/^[[:blank:]]\?CHROOT="\([^"]\+\)"/\1/p' /etc/conf.d/dhcp 2>/dev/null`

	if [ ! -d "${CHROOT:=/chroot/dhcp}" ] ; then
		ebegin "Setting up the chroot directory"
		mkdir -m 0755 -p "${CHROOT}/"{dev,etc,var/lib,var/run/dhcp}
		cp -R /etc/dhcp "${CHROOT}/etc/"
		cp -R /var/lib/dhcp "${CHROOT}/var/lib"
		chown -R dhcp:dhcp "${CHROOT}/var/lib" "${CHROOT}/var/run/dhcp"
		eend

		if [ "`grep '^#[[:blank:]]\?CHROOT' /etc/conf.d/dhcp`" ] ; then
			sed -e '/^#[[:blank:]]\?CHROOT/s/^#[[:blank:]]\?//' -i /etc/conf.d/dhcp
		fi

		einfo "To enable logging from the DHCP server, configure your"
		einfo "logger (`best_version virtual/logger`) to listen on ${CHROOT}/dev/log"
	else
		eerror
		eerror "${CHROOT} already exists. Quitting."
		eerror
	fi
}
