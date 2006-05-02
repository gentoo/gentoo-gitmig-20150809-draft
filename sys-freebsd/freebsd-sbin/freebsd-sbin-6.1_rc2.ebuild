# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sbin/freebsd-sbin-6.1_rc2.ebuild,v 1.1 2006/05/02 21:59:39 flameeyes Exp $

inherit flag-o-matic bsdmk freebsd

DESCRIPTION="FreeBSD sbin utils"
KEYWORDS="~x86-fbsd"
SLOT="0"

SRC_URI="mirror://gentoo/${SBIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	=sys-freebsd/freebsd-libexec-${RV}*
	ssl? ( dev-libs/openssl )
	sys-libs/readline
	sys-process/vixie-cron"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

PROVIDE="virtual/dev-manager
	virtual/dhcpc"

S="${WORKDIR}/sbin"

IUSE="atm ipfilter ipv6 vinum suid ssl"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use ipfilter || mymakeopts="${mymakeopts} NO_IPFILTER= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use vinum || mymakeopts="${mymakeopts} NO_VINUM= "
	use suid || mymakeopts="${mymakeopts} NO_SUID= "

	# O3 breaks this, apparently
	replace-flags -O3 -O2
}

REMOVE_SUBDIRS="dhclient pfctl pflogd"

PATCHES="${FILESDIR}/${PN}-setXid.patch
	${FILESDIR}/${PN}-zlib.patch"

src_unpack() {
	freebsd_src_unpack
	ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"

	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}-6.1-devd-conf.patch"
}

src_install() {
	freebsd_src_install
	keepdir /var/log

	newinitd ${FILESDIR}/ipfw.initd ipfw
	newinitd ${FILESDIR}/sysctl.initd sysctl

	cd ${WORKDIR}/etc/
	insinto /etc
	doins devd.conf pccard_ether defaults/pccard.conf minfree rc.firewall \
		sysctl.conf

	# Install a crontab for adjkerntz
	insinto /etc/cron.d
	newins "${FILESDIR}/adjkerntz-crontab" adjkerntz

	# Install the periodic stuff (needs probably to be ported in a more
	# gentooish way)
	cd "${WORKDIR}/etc/periodic"

	doperiodic security \
		security/*.ipfwlimit \
		security/*.ip6fwlimit \
		security/*.ip6fwdenied \
		security/*.ipfwdenied

	use ipfilter && doperiodic security \
		security/*.ipf6denied \
		security/*.ipfdenied
}
