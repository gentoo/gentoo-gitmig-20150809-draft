# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.06.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $


MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Intel IA32 microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.bz2
	http://cvs.gentoo.org/~seemant/${P}-gentoo.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -ppc -sparc -hppa -mips -alpha"

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
	doins ${WORKDIR}/${PV}/microcode.dat
	exeinto /etc/init.d/
	doexe ${WORKDIR}/${PV}/microcode_ctl
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
