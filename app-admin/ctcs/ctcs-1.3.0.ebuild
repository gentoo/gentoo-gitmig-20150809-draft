# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ctcs/ctcs-1.3.0.ebuild,v 1.2 2006/12/03 00:46:36 beandog Exp $

inherit eutils

DESCRIPTION="CTCS (Cerberus Test Control System) used to stress systems for the real world"
HOMEPAGE="http://sourceforge.net/projects/va-ctcs/"
SRC_URI="mirror://sourceforge/va-ctcs/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dodoc CHANGELOG FAQ README.FIRST README README.TCF runin/README.runtest runin/README.tests

	exeinto /usr/ctcs/runin/bin
	doexe runin/src/cpuburn/{burnBX,burnMMX,burnP5,burnP6,burnK6,burnK7} || die "doexe cpuburn failed"

	cp -pPR lib selftest sample "${D}"/usr/ctcs/ || die "cp dirs"
	exeinto /usr/ctcs
	doexe burnreset check-requirements check-syntax color \
		newburn newburn-generator report run || die "doexe binaries"

	cp -pPR runin/src/{random,chartst,prandom} "${D}"/usr/ctcs/runin/bin/ || die "copy bins"
	cp -pPR runin/src/flushb "${D}"/usr/ctcs/runin/bin/flushb.real || die "copy flushb"
	cp -pPR runin/src/chartst runin/src/memtst.src/memtst \
		"${D}"/usr/ctcs/runin/ || die "copy chartst"

	cd runin
	exeinto /usr/ctcs/runin
	doexe messages-info blockrdtst blockrdtst-info data data-info destructiveblocktst \
		destructiveblocktst-info traverseread-info traverseread || die "doexe runin failed"
	dosym messages-info /usr/ctcs/runin/allmessages-info
	dosym blockrdtst /usr/ctcs/runin/sblockrdtst
	dosym blockrdtst-info /usr/ctcs/runin/sblockrdtst-info
	dosym data /usr/ctcs/runin/sdata
	dosym data-info /usr/ctcs/runin/sdata-info
	dosym destructiveblocktst /usr/ctcs/runin/sdestructiveblocktst
	dosym destructiveblocktst-info /usr/ctcs/runin/sdestructiveblocktst-info
	dosym traverseread-info /usr/ctcs/runin/straverseread-info
	dosym traverseread /usr/ctcs/runin/straverseread

	find "${D}" -name CVS -type d -print0 | xargs -0 rm -rf
}

pkg_postinst() {
	ewarn "CTCS (Cerberus Test Control System) used to make sure that"
	ewarn "new systems are ready to go out and face the perils of the"
	ewarn "cold, hard world.  It's made up of a suite of programs that"
	ewarn "literally pound the system.  The tests are meant for hardware"
	ewarn "with nothing on it yet... you will lose data.  Not might."
	ewarn "Will.  Please read at least README.FIRST before attempting"
	ewarn "to use the Cerberus Test Control System as certain"
	ewarn "configurations of CTCS may damage your system."
}
