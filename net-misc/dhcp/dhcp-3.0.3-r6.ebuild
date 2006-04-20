# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-3.0.3-r6.ebuild,v 1.8 2006/04/20 20:06:16 uberlord Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

MY_PV="${PV//_beta/b}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${MY_P}.tar.gz"

LICENSE="isc-dhcp"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="static selinux"

RDEPEND="selinux? ( sec-policy/selinux-dhcp )
	kernel_linux? ( sys-apps/net-tools )"
DEPEND="selinux? ( sec-policy/selinux-dhcp )
	>=sys-apps/sed-4"

PROVIDE="virtual/dhcpc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Gentoo patches - these will probably never be accepted upstream
	# Enable chroot support
	epatch "${FILESDIR}/${PN}-3.0-paranoia.patch"
	# Fix some permission issues
	epatch "${FILESDIR}/${PN}-3.0-fix-perms.patch"
	# Enable dhclient to equery NTP servers
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-ntp.patch"
	# resolvconf support in dhclient-script
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-resolvconf.patch"
	# Fix setting hostnames on Linux
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-hostname.patch"
	# Allow mtu settings
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-mtu.patch"
	# Allow dhclient to use IF_METRIC to set route metrics
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-metric.patch"
	# Stop downing the interface on Linux as that breaks link dameons
	# such as wpa_supplicant and netplug
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-no-down.patch"
	# Quiet the isc blurb
	epatch "${FILESDIR}/${PN}-3.0.3-no_isc_blurb.patch"
	# Enable dhclient to get extra configuration from stdin
	epatch "${FILESDIR}/${PN}-3.0.3-dhclient-stdin-conf.patch"

	# General fixes which will probably be accepted upstream eventually
	# Fix token ring compiling, #102473
	epatch "${FILESDIR}/${P}-tr.patch"
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

	# Change the hook script locations of the scripts
	sed -i -e 's,/etc/dhclient-exit-hooks,/etc/dhcp/dhclient-exit-hooks,g' \
		-e 's,/etc/dhclient-enter-hooks,/etc/dhcp/dhclient-enter-hooks,g' \
		client/scripts/*

	# Remove these options from the sample config
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
	ADMMANEXT = .8
	FFMANDIR = /usr/share/man/man5
	FFMANEXT = .5
	LIBMANDIR = /usr/share/man/man3
	LIBMANEXT = .3
	USRMANDIR = /usr/share/man/man1
	USRMANEXT = .1
	MANCAT = man
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

	newinitd "${FILESDIR}/dhcpd.init" dhcpd
	newinitd "${FILESDIR}/dhcrelay.init" dhcrelay
	insinto /etc/conf.d
	newins "${FILESDIR}/dhcpd.conf" dhcpd
	newins "${FILESDIR}/dhcrelay.conf" dhcrelay

	keepdir /var/{lib,run}/dhcp
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}

pkg_postinst() {
	chown dhcp:dhcp "${ROOT}"/var/{lib,run}/dhcp

	if [[ -e "${ROOT}/etc/init.d/dhcp" ]] ; then
		ewarn
		ewarn "WARNING: The dhcp init script has been renamed to dhcpd"
		ewarn "/etc/init.d/dhcp and /etc/conf.d/dhcp need to be removed and"
		ewarn "and dhcp should be removed from the default runlevel"
		ewarn
	fi

	einfo "You can edit /etc/conf.d/dhcpd to customize dhcp settings."
	einfo
	einfo "If you would like to run dhcpd in a chroot, simply configure the"
	einfo "DHCPD_CHROOT directory in /etc/conf.d/dhcpd and then run:"
	einfo "  emerge --config =${PF}"
}

pkg_config() {
	local CHROOT="$(
		sed -n 's/^[[:blank:]]\?DHCPD_CHROOT="*\([^#"]\+\)"*/\1/p' \
		/etc/conf.d/dhcpd
	)"

	if [[ -z ${CHROOT} ]]; then
		eerror "CHROOT not defined in /etc/conf.d/dhcpd"
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
	einfo "To enable logging from the dhcpd server, configure your"
	einfo "logger (${logger}) to listen on ${CHROOT}/dev/log"
}
