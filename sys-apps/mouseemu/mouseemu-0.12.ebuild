# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mouseemu/mouseemu-0.12.ebuild,v 1.1 2004/08/20 00:02:35 pvdabeel Exp $

inherit eutils

DESCRIPTION="Emulates scrollwheel, right- & left-click for one-button mice/touchpads"
HOMEPAGE="http://geekounet.org/powerbook/"
SRC_URI="http://geekounet.org/powerbook/files/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE=""
DEPEND=""
RDEPEND="$DEPEND"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/${PN} ${WORKDIR}/${P}
	epatch ${FILESDIR}/${P}-fix.diff
}

src_compile() {
	emake || die
}

src_install() {
	einstall || die
	dobin mouseemu
	dodoc README COPYING
	exeinto /etc/init.d/; doexe mouseemu.init.gentoo
	mv /etc/init.d/mouseemu.init.gentoo /etc/init.d/mouseemu
	insinto /etc; doins mouseemu.conf
}

pkg_postinst() {
	einfo "For mouseemu to work you need uinput support in your kernel:"
	einfo "        CONFIG_INPUT_UINPUT=y"
	einfo "(Device Drivers->Input device support->Misc->User level driver support)"
	einfo "Don't forget to add mouseemu to your default runlevel:"
	einfo "        rc-update add mouseemu default"
	einfo "Configuration is in /etc/mouseemu.conf."
}
