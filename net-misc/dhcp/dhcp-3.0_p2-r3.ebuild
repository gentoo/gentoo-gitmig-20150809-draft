# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0_p2-r3.ebuild,v 1.3 2004/01/15 01:04:44 max Exp $

inherit eutils flag-o-matic

DESCRIPTION="ISC Dynamic Host Configuration Protocol."
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P/_p/pl}.tar.gz
	http://www.episec.com/people/edelkind/patches/dhcp/dhcp-3.0+paranoia.patch"

LICENSE="isc-dhcp"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~sparc ~mips hppa"
IUSE="static"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

S="${WORKDIR}/${P/_p/pl}"

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/dhcp-3.0pl2-user-option-fix.patch"
	epatch "${FILESDIR}/dhclient.c-3.0-dw-cli-fix.patch"
	epatch "${DISTDIR}/dhcp-3.0+paranoia.patch"
	epatch "${FILESDIR}/dhcp-3.0pl2-fix-perms.patch"
}

src_compile() {
	# 01/Mar/2003: Fix for bug #11960 by Jason Wever <weeve@gentoo.org>
	if [ "${ARCH}" = "sparc" ] ; then
		filter-flags "-O3"
		filter-flags "-O2"
		filter-flags "-O"
	fi

	use static && append-flags -static

	cat <<-END >> includes/site.h
	#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
	#define _PATH_DHCPD_PID "/var/run/dhcp/dhcpd.pid"
	#define _PATH_DHCPD_DB "/var/lib/dhcp/dhcpd.leases"
	#define _PATH_DHCLIENT_DB "/var/lib/dhcp/dhclient.leases"
	#define DHCPD_LOG_FACILITY LOG_LOCAL1
	END

	cat <<-END > site.conf
	CC = gcc
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

	./configure --with-nsupdate \
		--copts "-DPARANOIA -DEARLY_CHROOT ${CFLAGS}" || die "configure failed"

	emake || die "compile problem"
}

src_install() {
	enewgroup dhcp
	enewuser dhcp -1 /bin/false /var/lib/dhcp dhcp

	einstall DESTDIR="${D}"

	insinto /etc/dhcp
	newins server/dhcpd.conf dhcpd.conf.sample
	newins client/dhclient.conf dhclient.conf.sample
	dosed "s:/etc/dhclient-script:/etc/dhcp/dhclient-script:" \
		/etc/dhcp/dhclient.conf.sample
	mv "${D}/sbin/dhclient-script" "${D}/etc/dhcp/dhclient-script.sample"

	dodoc ANONCVS CHANGES COPYRIGHT README RELNOTES doc/*
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
		mkdir -m 0755 -p "${CHROOT}/"{dev,etc,var/lib,var/run}
		cp -R /etc/dhcp "${CHROOT}/etc/"
		cp -R /var/lib/dhcp "${CHROOT}/var/lib"
		chown -R dhcp:dhcp "${CHROOT}/var/lib" "${CHROOT}/var/run"
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
