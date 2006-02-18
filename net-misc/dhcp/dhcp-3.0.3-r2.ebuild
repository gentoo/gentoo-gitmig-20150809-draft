# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0.3-r2.ebuild,v 1.11 2006/02/18 11:59:19 blubb Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${P}.tar.gz"

LICENSE="isc-dhcp"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa mips ppc ppc64 s390 sh sparc x86"
IUSE="static selinux"

RDEPEND="virtual/libc
	selinux? ( sec-policy/selinux-dhcp )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Enable chroot
	epatch "${FILESDIR}/${PN}-3.0-paranoia.patch"
	# Fix some permission issues
	epatch "${FILESDIR}/${PN}-3.0-fix-perms.patch"
	# Fix token ring compiling, #102473 
	epatch "${FILESDIR}/${P}-tr.patch"
	# Install libdst, #75544
	epatch "${FILESDIR}/${P}-libdst.patch"
	# Fix building on Gentoo/FreeBSD
	epatch "${FILESDIR}/${PN}-3.0.2-gmake.patch"

	# Enable dhclient to equery NTP servers, fixed #63868
	epatch "${FILESDIR}/dhclient-ntp.patch"

	# FreeBSD doesn't like -Werror that is forced on
	sed -i -e 's:-Werror::' Makefile.conf
}

src_compile() {
	# 01/Mar/2003: Fix for bug #11960 by Jason Wever <weeve@gentoo.org>
	[[ ${ARCH} == "sparc" ]] && filter-flags -O3 -O2 -O

	use static && append-ldflags -static

	cat <<-END >> includes/site.h
	#define _PATH_DHCPD_CONF "/etc/dhcp/dhcpd.conf"
	#define _PATH_DHCPD_PID "/var/run/dhcp/dhcpd.pid"
	#define _PATH_DHCPD_DB "/var/lib/dhcp/dhcpd.leases"
	#define _PATH_DHCLIENT_DB "/var/lib/dhcp/dhclient.leases"
	#define DHCPD_LOG_FACILITY LOG_LOCAL1
	END

	cat <<-END > site.conf
	CC = $(tc-getCC)
	LFLAGS = ${LDFLAGS}
	LIBDIR = /usr/$(get_libdir)
	INCDIR = /usr/include
	ETC = /etc/dhcp
	VARDB = /var/lib/dhcp
	VARRUN = /var/run/dhcp
	ADMMANDIR = /usr/share/man/man8
	FFMANDIR = /usr/share/man/man5
	LIBMANDIR = /usr/share/man/man3
	USRMANDIR = /usr/share/man/man1
	END

	./configure --copts "-DPARANOIA -DEARLY_CHROOT ${CFLAGS}" \
		|| die "configure failed"

	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die

	insinto /etc/dhcp
	newins server/dhcpd.conf dhcpd.conf.sample
	newins client/dhclient.conf dhclient.conf.sample

	dodoc README RELNOTES doc/*
	newdoc client/dhclient.conf dhclient.conf.sample
	newdoc client/scripts/linux dhclient-script.sample
	newdoc server/dhcpd.conf dhcpd.conf.sample

	newinitd "${FILESDIR}/dhcp.init" dhcp
	newinitd "${FILESDIR}/dhcrelay.init" dhcrelay
	insinto /etc/conf.d
	newins "${FILESDIR}/dhcp.conf" dhcp
	newins "${FILESDIR}/dhcrelay.conf" dhcrelay

	keepdir /var/{lib,run}/dhcp
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}

pkg_postinst() {
	chown dhcp:dhcp "${ROOT}"/var/{lib,run}/dhcp

	einfo "You can edit /etc/conf.d/dhcp to customize dhcp settings"
	einfo
	einfo "The DHCP ebuild now includes chroot support."
	einfo "If you would like to run dhcpd in a chroot, simply configure the"
	einfo "CHROOT directory in /etc/conf.d/dhcp and then run:"
	einfo "  emerge --config =${PF}"
	echo
}

pkg_config() {
	CHROOT="$(
		sed -n 's/^[[:blank:]]\?CHROOT="*\([^#"]\+\)"*/\1/p' \
		/etc/conf.d/dhcp
	)"

	if [[ -z ${CHROOT} ]]; then
		eerror "CHROOT not defined in /etc/conf.d/dhcp"
		return 1
	fi

	if [[ -d ${CHROOT} ]] ; then
		ewarn "${CHROOT} already exists - aborting"
		return 0
	fi

	ebegin "Setting up the chroot directory"
	mkdir -m 0755 -p "${CHROOT}/"{dev,etc,var/lib,var/run/dhcp}
	cp /etc/{localtime,resolv.conf} "${CHROOT}/etc"
	cp -R /etc/dhcp "${CHROOT}/etc/"
	cp -R /var/lib/dhcp "${CHROOT}/var/lib"
	chown -R dhcp:dhcp "${CHROOT}"/var/{lib,run}/dhcp
	eend

	local logger="$(best_version virtual/logger)"
	einfo "To enable logging from the DHCP server, configure your"
	einfo "logger (${logger}) to listen on ${CHROOT}/dev/log"
}
