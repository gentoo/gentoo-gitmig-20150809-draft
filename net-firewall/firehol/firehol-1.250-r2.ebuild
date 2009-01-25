# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firehol/firehol-1.250-r2.ebuild,v 1.6 2009/01/25 01:11:35 darkside Exp $

inherit eutils

DESCRIPTION="iptables firewall generator"
HOMEPAGE="http://firehol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-1.226.tar.bz2
	mirror://gentoo/${PN}-1.226-to-250.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc x86"

DEPEND="sys-apps/iproute2"
RDEPEND="net-firewall/iptables
	sys-apps/iproute2
	virtual/modutils
	|| (
		net-misc/wget
		net-misc/curl
	)"

S="${WORKDIR}/${PN}-1.226"

pkg_setup() {
	# Bug 81600 fail if iproute2 is built with minimal
	if built_with_use sys-apps/iproute2 minimal; then
		eerror "Firehol requires iproute2 to be emerged without"
		eerror "the USE-Flag \"minimal\"."
		eerror "Re-emerge iproute2 with"
		eerror "USE=\"-minimal\" emerge sys-apps/iproute2"
		die "sys-apps/iproute2 without USE=\"minimal\" needed"
	fi
}

# patch for embedded Gentoo - GNAP
# backport from firehol-CVS.
src_unpack() {
	unpack ${A}
	cd "${S}" || die
	epatch "${FILESDIR}/firehol-1.226-to-228.patch" || die
	epatch "${WORKDIR}/firehol-1.226-to-250.patch" || die
	# invalid, see Bug 176862 epatch ${FILESDIR}/${P}-groupwith.patch || die
	epatch "${FILESDIR}/${P}-printf.patch" || die
}

src_install() {
	newsbin firehol.sh firehol

	dodir /etc/firehol /etc/firehol/examples /etc/firehol/services
	insinto /etc/firehol/examples
	doins examples/* || die

	newconfd "${FILESDIR}/firehol.conf.d" firehol || die

	dodoc ChangeLog README TODO WhatIsNew || die
	dohtml doc/*.html doc/*.css  || die

	docinto scripts
	dodoc get-iana.sh adblock.sh || die

	doman man/*.1 man/*.5 || die

	newinitd "${FILESDIR}/firehol.initrd" firehol || die
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
