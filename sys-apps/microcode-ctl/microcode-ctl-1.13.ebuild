# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.13.ebuild,v 1.2 2006/09/11 15:53:26 chainsaw Exp $

inherit toolchain-funcs

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/os-headers
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "compile problem"
}

src_install() {
	dosbin microcode_ctl || die "dosbin"
	doman microcode_ctl.8
	dodoc Changelog README

	insinto /etc
	newins intel-ia32microcode-*.txt microcode.dat

	newinitd "${FILESDIR}"/microcode_ctl.rc microcode_ctl
	newconfd "${FILESDIR}"/microcode_ctl.conf.d microcode_ctl
}

pkg_postinst() {
	ewarn "Your kernel must include microcode update support."
	echo
	einfo "Microcode updates will be lost at every reboot."
	einfo "You can use the init.d script to update at boot time."
}
