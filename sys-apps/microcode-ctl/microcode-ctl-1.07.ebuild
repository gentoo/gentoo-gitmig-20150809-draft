# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.07.ebuild,v 1.2 2004/06/24 22:16:01 agriffis Exp $

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz
	mirror://gentoo/${PN}-1.06-r1-gentoo.tar.bz2"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 -ppc -sparc -hppa -mips -alpha"

DEPEND="virtual/linux-sources"

src_compile() {
	make all || die "compile problem"
}

src_install() {
	into /usr/
	dosbin microcode_ctl
	doman microcode_ctl.8
	dodoc Changelog README
	insinto /etc/
	doins ${WORKDIR}/1.06/microcode.dat
	exeinto /etc/init.d/
	doexe ${WORKDIR}/1.06/microcode_ctl
}

pkg_postinst() {
	einfo "Your kernel must include both devfs and microcode update support."
	echo
	einfo "To update the microcode now, run"
	einfo ""
	einfo "\tmicrocode_ctl -u"
	einfo ""
	einfo "The update will not survive a reboot. To have it do that run"
	einfo ""
	einfo "\trc-update add microcode_ctl default"
	einfo ""
	einfo "NOTE: For 2.6x series kernels, use the '-d' flag to specify a"
	einfo "      different microcode device: /dev/misc/microcode"
}
