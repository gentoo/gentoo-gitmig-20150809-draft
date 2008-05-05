# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.17-r1.ebuild,v 1.1 2008/05/05 04:05:57 vapier Exp $

inherit toolchain-funcs

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Intel processor microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/microcode-data"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${CPPFLAGS} ${LDFLAGS}" \
		|| die "compile problem"
}

src_install() {
	dosbin microcode_ctl || die "dosbin"
	doman microcode_ctl.8
	dodoc Changelog README

	newinitd "${FILESDIR}"/microcode_ctl.rc microcode_ctl
	newconfd "${FILESDIR}"/microcode_ctl.conf.d microcode_ctl
}

pkg_postinst() {
	ewarn "Your kernel must include microcode update support."
	echo
	einfo "Microcode updates will be lost at every reboot."
	einfo "You can use the init.d script to update at boot time."
}
