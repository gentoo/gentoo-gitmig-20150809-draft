# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.08.ebuild,v 1.1 2004/09/01 01:16:46 vapier Exp $

inherit gcc

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

DEPEND="virtual/os-headers"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake \
		CC="$(gcc-getCC)" \
		CFLAGS="${CFLAGS} -I${ROOT}/usr/include" \
		|| die "compile problem"
}

src_install() {
	dosbin microcode_ctl || die "dosbin"
	doman microcode_ctl.8
	dodoc Changelog README

	insinto /etc
	newins intel-ia32microcode-27July2004.txt microcode.dat

	exeinto /etc/init.d ; newexe ${FILESDIR}/microcode_ctl.rc microcode_ctl
	insinto /etc/conf.d ; newexe ${FILESDIR}/microcode_ctl.conf.d microcode_ctl
}

pkg_postinst() {
	ewarn "Your kernel must include microcode update support."
	echo
	einfo "Microcode updates will be lost at every reboot."
	einfo "You can use the init.d script to update at boot time."
}
