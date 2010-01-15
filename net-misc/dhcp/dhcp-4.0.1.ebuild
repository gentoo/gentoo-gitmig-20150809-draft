# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp/dhcp-4.0.1.ebuild,v 1.2 2010/01/15 19:00:22 ulm Exp $

inherit eutils flag-o-matic autotools

MY_PV="${PV//_alpha/a}"
MY_PV="${MY_PV//_beta/b}"
MY_PV="${MY_PV//_rc/rc}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="ISC Dynamic Host Configuration Protocol"
HOMEPAGE="http://www.isc.org/products/DHCP"
SRC_URI="ftp://ftp.isc.org/isc/dhcp/${MY_P}.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="doc ipv6 selinux kernel_linux vim-syntax"

DEPEND="selinux? ( sec-policy/selinux-dhcp )
	kernel_linux? ( sys-apps/net-tools )
	vim-syntax? ( app-vim/dhcpd-syntax )"

PROVIDE="virtual/dhcpc"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Gentoo patches - these will probably never be accepted upstream
	# Enable chroot support
	epatch "${FILESDIR}/${PN}"-4.0-paranoia.patch
	# Fix some permission issues
	epatch "${FILESDIR}/${PN}"-3.0-fix-perms.patch
	# Enable dhclient to equery NTP servers
	epatch "${FILESDIR}/${PN}"-4.0-dhclient-ntp.patch
	# resolvconf support in dhclient-script
	epatch "${FILESDIR}/${PN}"-4.0-dhclient-resolvconf.patch
	# Fix setting hostnames on Linux
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-hostname.patch
	# Allow mtu settings
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-mtu.patch
	# Allow dhclient to use IF_METRIC to set route metrics
	epatch "${FILESDIR}/${PN}"-4.0-dhclient-metric.patch
	# Stop downing the interface on Linux as that breaks link daemons
	# such as wpa_supplicant and netplug
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-no-down.patch
	# Quiet the isc blurb
	epatch "${FILESDIR}/${PN}"-4.0-no_isc_blurb.patch
	# Enable dhclient to get extra configuration from stdin
	epatch "${FILESDIR}/${PN}"-4.0.1-dhclient-stdin-conf.patch
	# Disable fallback interfaces when using BPF
	# This allows more than one dhclient instance on the BSD's
	epatch "${FILESDIR}/${PN}"-3.0.5-bpf-nofallback.patch
	# This allows the software to actually compile on linux
	epatch "${FILESDIR}/${PN}"-4.0-linux-ipv6-header.patch
	# Consistent style for the if statements, also resolves
	# unary operator expected warnings (new style is wrong).
	epatch "${FILESDIR}/${PN}"-4.0-dhclient-script-correct-operators.patch

	# NetworkManager support patches
	# If they fail to apply to future versions they will be dropped
	# Add dbus support to dhclient
	epatch "${FILESDIR}/${PN}"-3.0.3-dhclient-dbus.patch

	# Brand the version with Gentoo
	# include revision if >0
	local newver="Gentoo"
	[[ ${PR} != "r0" ]] && newver="${newver}-${PR}"

	sed -i "/AC_INIT/s/\(\[[0-9]\+\.[0-9]\+\.[0-9]\+\)/\1-${newver}/" \
		configure.ac || die

	# Change the hook script locations of the scripts
	sed -i -e 's,/etc/dhclient-exit-hooks,/etc/dhcp/dhclient-exit-hooks,g' \
		-e 's,/etc/dhclient-enter-hooks,/etc/dhcp/dhclient-enter-hooks,g' \
		client/scripts/* || die

	# No need for the linux script to force bash, #158540.
	sed -i -e 's,#!/bin/bash,#!/bin/sh,' client/scripts/linux || die

	# Quiet the freebsd logger a little
	sed -i -e '/LOGGER=/ s/-s -p user.notice //g' client/scripts/freebsd || die

	# Remove these options from the sample config
	sed -i -e "/\(script\|host-name\|domain-name\) / d" \
		client/dhclient.conf || die

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

	eautoreconf
}

src_compile() {
	econf \
		--enable-paranoia \
		--sysconfdir /etc/dhcp \
		--with-cli-pid-file=/var/run/dhcp/dhclient.pid \
		--with-cli-lease-file=/var/lib/dhcp/dhclient.leases \
		--with-srv-pid-file=/var/run/dhcp/dhcpd.pid \
		--with-srv-lease-file=/var/lib/dhcp/dhcpd.leases \
		--with-relay-pid-file=/var/run/dhcp/dhcrelay.pid \
		$(use_enable ipv6 dhcpv6) \
		|| die

	emake || die "compile problem"
}

src_install() {
	for installdir in includes tests common minires dst omapip client dhcpctl relay server; do
		cd "${S}/${installdir}"
		if [ "${installdir}" == client ]; then
			make install DESTDIR="${D}" exec_prefix="" || die
		else
			make install DESTDIR="${D}" exec_prefix="/usr" || die
		fi
	done

	cd "${S}"

	exeinto /sbin
	if use kernel_linux; then
		newexe "${S}"/client/scripts/linux dhclient-script
	else
		newexe "${S}"/client/scripts/freebsd dhclient-script
	fi

	use doc && dodoc README RELNOTES doc/*

	insinto /etc/dhcp
	newins client/dhclient.conf dhclient.conf.sample
	keepdir /var/{lib,run}/dhcp

	# Install our server files
	insinto /etc/dhcp
	newins server/dhcpd.conf dhcpd.conf.sample
	newinitd "${FILESDIR}"/dhcpd.init dhcpd
	newinitd "${FILESDIR}"/dhcrelay.init dhcrelay
	newconfd "${FILESDIR}"/dhcpd.conf dhcpd
	newconfd "${FILESDIR}"/dhcrelay.conf dhcrelay

	# We never want portage to own this file
	rm -f "${D}"/var/lib/dhcp/dhcpd.leases
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}

pkg_postinst() {
	chown dhcp:dhcp "${ROOT}"/var/{lib,run}/dhcp

	if [[ -e "${ROOT}"/etc/init.d/dhcp ]] ; then
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
		sed -n -e 's/^[[:blank:]]\?DHCPD_CHROOT="*\([^#"]\+\)"*/\1/p' \
		"${ROOT}"/etc/conf.d/dhcpd
	)"

	if [[ -z ${CHROOT} ]]; then
		eerror "CHROOT not defined in /etc/conf.d/dhcpd"
		return 1
	fi

	CHROOT="${ROOT}/${CHROOT}"

	if [[ -d ${CHROOT} ]] ; then
		ewarn "${CHROOT} already exists - aborting"
		return 0
	fi

	ebegin "Setting up the chroot directory"
	mkdir -m 0755 -p "${CHROOT}/"{dev,etc,var/lib,var/run/dhcp}
	cp /etc/{localtime,resolv.conf} "${CHROOT}"/etc
	cp -R /etc/dhcp "${CHROOT}"/etc
	cp -R /var/lib/dhcp "${CHROOT}"/var/lib
	ln -s ../../var/lib/dhcp "${CHROOT}"/etc/dhcp/lib
	chown -R dhcp:dhcp "${CHROOT}"/var/{lib,run}/dhcp
	eend 0

	local logger="$(best_version virtual/logger)"
	einfo "To enable logging from the dhcpd server, configure your"
	einfo "logger (${logger}) to listen on ${CHROOT}/dev/log"
}
