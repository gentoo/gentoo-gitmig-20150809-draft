# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/ltp/ltp-20041203.ebuild,v 1.4 2005/08/07 12:04:32 blubb Exp $

inherit eutils

MY_P="${PN}-full-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Linux Test Project: testsuite for the linux kernel"
HOMEPAGE="http://ltp.sourceforge.net/"
SRC_URI="mirror://sourceforge/ltp/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

# add "dialog" here if ltpmenu is enabled
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/IDcheck-noninteractive.patch
	epatch ${FILESDIR}/runltp-path.patch
	epatch ${FILESDIR}/ltp-${PV}-ballista-paths.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install || die "install failed"

	mkdir -p ${D}/usr/libexec/ltp/testcases ${D}/usr/bin/ || die "mkdir failed"
	cp --parents -r testcases pan/pan runtest ver_linux IDcheck.sh ${D}/usr/libexec/ltp || die "cp failed"
	cp runltp runalltests.sh ${D}/usr/bin || die "cp failed"

	# TODO: fix this so it works from "outside" the source tree
	# cp ltpmenu ${D}/usr/bin
}
