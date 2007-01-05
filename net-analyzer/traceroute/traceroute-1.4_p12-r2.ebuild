# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12-r2.ebuild,v 1.13 2007/01/05 08:42:24 flameeyes Exp $

inherit eutils flag-o-matic

MY_P="${PN}-1.4a12"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="http://ee.lbl.gov/"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/${PN}-1.4-genpatches.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm amd64 ppc64 ia64 hppa"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use sparc && epatch "${WORKDIR}"/traceroute-1.4a12.patch
	epatch "${WORKDIR}"/traceroute-1.4-target-resolv.patch
}

src_compile() {
	# fixes bug #21122
	# -taviso

	# use non-lazy bindings for this suid app
	append-ldflags -Wl,-z,now

	# assume linux by default #26699
	# -taviso
	sed -i 's/t="generic"/t="linux"/g' "${S}"/configure.in
	autoreconf

	econf || die
	emake LIBS="${LDFLAGS}" || die
}

src_install() {
	dodir /usr/sbin
	make DESTDIR="${D}" install || die
	fowners root:wheel /usr/sbin/traceroute
	fperms 4710 /usr/sbin/traceroute

	doman traceroute.8
	dodoc CHANGES
}
