# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-2.2.9-r1.ebuild,v 1.3 2011/04/22 10:39:47 jlec Exp $

EAPI="4"

inherit toolchain-funcs eutils

DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug gtk prelude tcpd"

DEPEND="
	~net-analyzer/nessus-libraries-${PV}
	~net-analyzer/libnasl-${PV}
	tcpd? ( sys-apps/tcp-wrappers )
	gtk? ( x11-libs/gtk+:2 )
	prelude? ( dev-libs/libprelude )
	!net-analyzer/nessus-client"

S="${WORKDIR}"/${PN}

DOCS="README* UPGRADE_README CHANGES doc/*.txt doc/ntp/*"

src_prepare() {
	tc-export CC
	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${PV}-crash.patch \
		"${FILESDIR}"/${PV}-asneeded.patch
	sed \
		-e "/^LDFLAGS/s:$:${LDFLAGS}:g" \
		-i nessus.tmpl.in
}

src_configure() {
	econf \
		$(use_enable tcpd tcpwrappers) \
		$(use_enable debug) \
		$(use_enable gtk)
}

src_compile() {
	emake -C nessus cflags
	emake -C nessusd cflags
	default
}

src_install() {
	default
	newinitd "${FILESDIR}"/nessusd-r7 nessusd
	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users
	# newer version is provided by nessus-libraries
	# should be fixed upstream in version 2.2.6
	rm "${D}"/usr/include/nessus/includes.h
}
