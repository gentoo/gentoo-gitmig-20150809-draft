# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode_ctl/microcode_ctl-1.06.ebuild,v 1.9 2002/12/09 04:37:26 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
KEYWORDS="x86 -ppc -sparc "
SLOT="0"
LICENSE="GPL-2"
SRC_URI="http://www.urbanmyth.org/microcode/${P}.tar.gz"
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
	doins ${FILESDIR}/${PVR}/microcode.dat
	exeinto /etc/init.d/
	doexe ${FILESDIR}/${PVR}/microcode_ctl
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
}
