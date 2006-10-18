# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12-r5.ebuild,v 1.8 2006/10/18 21:57:47 exg Exp $

inherit eutils flag-o-matic

MY_P="${PN}-${PV/_p/a}"
DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="http://ee.lbl.gov/"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/${PN}-1.4-genpatches.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~x86-fbsd"
IUSE="static"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# nasty hack until bug 93363 is fixed
	chmod 644 config.{guess,sub}

	epatch ${WORKDIR}/${PN}-1.4-target-resolv.patch
	epatch ${WORKDIR}/${PN}-1.4a12-LDFLAGS.patch
	epatch ${WORKDIR}/${PN}-1.4a5-bigpacklen.patch
	epatch ${WORKDIR}/${PN}-1.4a12.patch
	epatch ${WORKDIR}/${PN}-1.4a5-droproot.patch
	epatch ${WORKDIR}/${PN}-1.4a5-llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch.patch
	epatch ${WORKDIR}/${PN}-1.4a5-secfix.patch
	epatch ${WORKDIR}/${PN}-1.4a5-unaligned.patch
	epatch ${WORKDIR}/${PN}-1.4-emptylabel.patch
	epatch ${FILESDIR}/${PN}-1.4a12-mpls-icmp-02.patch

	# assume linux by default #26699
	sed -i '/^t=/s:generic:linux:' configure

	# bug 126065
	epatch ${FILESDIR}/traceroute-configure-LANG.patch

	use static && append-ldflags -static
	append-ldflags $(bindnow-flags) -Wl,-z,relro
}

src_install() {
	dosbin traceroute || die "dosbin"
	fowners root:wheel /usr/sbin/traceroute
	fperms 4711 /usr/sbin/traceroute

	doman traceroute.8
	dodoc CHANGES
}
