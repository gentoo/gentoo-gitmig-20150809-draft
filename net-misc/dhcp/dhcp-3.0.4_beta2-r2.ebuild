# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0.4_beta2-r2.ebuild,v 1.1 2006/02/24 12:36:44 uberlord Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"

MY_PV="${PV//_beta/b}"
MY_P="${PN}-${MY_PV}"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="isc-dhcp"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static selinux"

RDEPEND="virtual/libc
	selinux? ( sec-policy/selinux-dhcp )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Gentoo patches - these will probably never be accepted upstream
	# Enable chroot support
	epatch "${FILESDIR}/${PN}-3.0-paranoia.patch"
	# Fix some permission issues
	epatch "${FILESDIR}/${PN}-3.0-fix-perms.patch"
	# Enable dhclient to equery NTP servers, fixed #63868
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-ntp.patch"
	# Quiet the isc blurb
	epatch "${FILESDIR}/${PN}-3.0.3-no_isc_blurb.patch"
	# Enable dhclient to get extra configuration from stdin
	epatch "${FILESDIR}/${P}-dhclient-stdin-conf.patch"

	# General fixes which will probably be accepted upstream eventually
	# Install libdst, #75544
	epatch "${FILESDIR}/${PN}-3.0.3-libdst.patch"
	# Fix building on Gentoo/FreeBSD
	epatch "${FILESDIR}/${PN}-3.0.2-gmake.patch"

	# Brand the version with Gentoo
	# include revision if >0
	local newver="${MY_PV}-Gentoo"
	[[ ${PR} != "r0" ]] && newver="${newver}-${PR}"
	sed -i -e '/^#define DHCP_VERSION[ \t]\+/ s/'"${MY_PV}/${newver}/g" \
		includes/version.h

	# Tart up the scripts for Gentoo baselayout
	local comment="# This script is not called by Gentoo net scripts\n"
	comment="${comment}# and is inluded purely for reference.\n"
	comment="${comment}# We do however call /etc/dhcp/dhclient-exit-hooks\n"
	sed -i -e '1 a '"${comment}" \
		-e 's,/etc/dhclient-exit-hooks,/etc/dhcp/dhclient-exit-hooks,g' \
		client/scripts/*

	# Remove these options from the sample config as they conflict
	# with baselayout network scripts
	sed -i -e "/\(script\|host-name\|domain-name\) / d" client/dhclient.conf

	# Only install different man pages if we don't have en
	if [[ " ${LINGUAS} " != *" en "* ]]; then
		# Install Japanese man pages
		if [[ " ${LINGUAS} " == *" ja "* && -d doc/ja_JP.eucJP ]]; then
			einfo "Installing Japanese documention"
			cp doc/ja_JP.eucJP/dhclient* client
			cp doc/ja_JP.eucJP/dhcp* common
		fi
	fi

	# Now remove the non-english docs so there are no errors later 
	[[ -d doc/ja_JP.eucJP ]] && rm -rf doc/ja_JP.eucJP
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

	einfo "You can edit /etc/conf.d/dhcp to customize dhcp settings."
	einfo
	einfo "The DHCP ebuild now includes chroot support."
	einfo "If you would like to run dhcpd in a chroot, simply configure the"
	einfo "CHROOT directory in /etc/conf.d/dhcp and then run:"
	einfo "  emerge --config =${PF}"
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
