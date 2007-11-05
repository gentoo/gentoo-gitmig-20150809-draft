# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.256-r1.ebuild,v 1.1 2007/11/05 14:07:54 centic Exp $

inherit eutils linux-info

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="sys-apps/iproute2"
RDEPEND="net-firewall/iptables
	sys-apps/iproute2
	virtual/modutils
	|| (
		net-misc/wget
		net-misc/curl
	)"

#S="${WORKDIR}/${PN}-1.226"

pkg_setup() {
	# Bug 81600 fail if iproute2 is built with minimal
	if built_with_use sys-apps/iproute2 minimal; then
		eerror "Firehol requires iproute2 to be emerged without"
		eerror "the USE-Flag \"minimal\"."
		eerror "Re-emerge iproute2 with"
		eerror "USE=\"-minimal\" emerge sys-apps/iproute2"
		die "sys-apps/iproute2 without USE=\"minimal\" needed"
	fi

	# perform checks for kernel config from eclass linux-info
	# for now we just print warnings as I am not sure if these
	# are required always...
	CONFIG_CHECK="~NF_CONNTRACK_ENABLED ~NF_CONNTRACK_IPV4 ~NF_CONNTRACK_MARK ~IP_NF_IPTABLES ~IP_NF_FILTER ~IP_NF_TARGET_REJECT ~IP_NF_TARGET_LOG ~IP_NF_TARGET_ULOG ~NF_NAT ~IP_NF_TARGET_MASQUERADE ~IP_NF_TARGET_REDIRECT ~IP_NF_MANGLE"
	linux-info_pkg_setup
}

# patch for embedded Gentoo - GNAP
# backport from firehol-CVS.
src_unpack() {
	unpack ${A}
	cd "${S}" || die
	# not needed any more according to http://bugs.gentoo.org/show_bug.cgi?id=172000#c15
	#epatch ${FILESDIR}/${P}-printf.patch || die

	# Bug 195378, binary is called zcat instead of gzcat, fixed upstream in later releases
	sed -i -e 's/gzcat/zcat/g' firehol.sh || die
	sed -i -e 's/GZCAT/ZCAT/g' firehol.sh || die
}

src_install() {
	newsbin firehol.sh firehol

	dodir /etc/firehol /etc/firehol/examples /etc/firehol/services
	insinto /etc/firehol/examples
	doins examples/* || die

	newconfd "${FILESDIR}/firehol.conf.d firehol" || die

	dodoc ChangeLog README TODO WhatIsNew || die
	dohtml doc/*.html doc/*.css  || die

	docinto scripts
	dodoc get-iana.sh adblock.sh || die

	doman man/*.1 man/*.5 || die

	newinitd "${FILESDIR}/firehol.initrd firehol" || die
}

pkg_postinst() {
	elog "The default path to firehol's configuration file is /etc/firehol/firehol.conf"
	elog "See /etc/firehol/examples for configuration examples."
	#
	# Install a default configuration if none is available yet
	if [[ ! -e "${ROOT}/etc/firehol/firehol.conf" ]]; then
		einfo "Installing a sample configuration as ${ROOT}/etc/firehol/firehol.conf"
		cp "${ROOT}/etc/firehol/examples/client-all.conf" "${ROOT}/etc/firehol/firehol.conf"
	fi
}
