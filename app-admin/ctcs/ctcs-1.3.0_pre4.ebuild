# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ctcs/ctcs-1.3.0_pre4.ebuild,v 1.22 2005/08/23 17:47:47 flameeyes Exp $

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CTCS (Cerberus Test Control System) used to stress systems for the real world"
HOMEPAGE="http://sourceforge.net/projects/va-ctcs/"
SRC_URI="mirror://sourceforge/va-ctcs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="dev-util/dialog
	app-shells/bash
	sys-apps/diffutils
	sys-fs/e2fsprogs
	sys-apps/grep
	virtual/modutils
	sys-process/psmisc
	sys-apps/sed
	sys-apps/coreutils
	sys-apps/util-linux
	sys-devel/make
	dev-lang/perl
	sys-libs/ncurses"

# Optional: app-admin/smartsuite  (depricated?)
# Optional: sys-apps/lm_sensors

src_compile() {
	emake || die
}

src_install() {
	dodoc CHANGELOG FAQ README.FIRST README README.TCF runin/README.runtest runin/README.tests

	dodir /usr/ctcs/runin/bin/

#	cp -R ${S}/runin ${D}/usr/ctcs/runin
	cp -pPR ${S}/lib ${D}/usr/ctcs/lib
	cp -pPR ${S}/selftest ${D}/usr/ctcs/selftest
	cp -pPR ${S}/sample ${D}/usr/ctcs/sample

	# The 'binaries'
	cp -p ${S}/burnreset ${S}/check-requirements ${S}/check-syntax ${S}/color \
		${S}/newburn ${S}/newburn-generator ${S}/report ${S}/run ${D}/usr/ctcs/

	cp -pPR ${S}/runin/src/random ${S}/runin/src/prandom ${D}/usr/ctcs/runin/bin/
	cp -pPR ${S}/runin/src/flushb ${D}/usr/ctcs/runin/bin/flushb.real
	cp -pPR ${S}/runin/src/chartst ${S}/runin/src/memtst.src/memtst \
		${D}/usr/ctcs/runin/

	for f in burnBX burnMMX burnP5 burnP6 burnK6 burnK7; do
		cp ${S}/runin/src/cpuburn/${f} ${D}/usr/ctcs/runin/bin/
	done
}

pkg_postinst() {
	cd /usr/ctcs/runin
	dosym messages-info allmessages-info
	dosym blockrdtst sblockrdtst
	dosym blockrdtst-info sblockrdtst-info
	dosym data sdata
	dosym data-info sdata-info
	dosym destructiveblocktst sdestructiveblocktst
	dosym destructiveblocktst-info sdestructiveblocktst-info
	dosym traverseread-info straverseread-info
	dosym traverseread straverseread

	ewarn "CTCS (Cerberus Test Control System) used to make sure that"
	ewarn "new systems are ready to go out and face the perils of the"
	ewarn "cold, hard world.  It's made up of a suite of programs that"
	ewarn "literally pound the system.  The tests are meant for hardware"
	ewarn "with nothing on it yet... you will lose data.  Not might."
	ewarn "Will.  Please read at least README.FIRST before attempting"
	ewarn "to use the Cerberus Test Control System as certain"
	ewarn "configurations of CTCS may damage your system."
}
