# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12-r5.ebuild,v 1.14 2007/02/27 18:00:48 vapier Exp $

inherit eutils flag-o-matic

MY_P="${PN}-${PV/_p/a}"
PATCH_VER="1.5"
DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="http://ee.lbl.gov/"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="static"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	use static && append-ldflags -static
}

src_install() {
	dosbin traceroute || die "dosbin"
	fowners root:wheel /usr/sbin/traceroute
	fperms 4711 /usr/sbin/traceroute

	doman traceroute.8
	dodoc CHANGES
}
