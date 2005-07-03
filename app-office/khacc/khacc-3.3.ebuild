# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/khacc/khacc-3.3.ebuild,v 1.1 2005/07/03 21:07:38 carlo Exp $

inherit kde

DESCRIPTION="KDE personal accounting system based on QHacc."
HOMEPAGE="http://qhacc.sourceforge.net"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"
IUSE=""


DEPEND="~app-office/qhacc-3.4"
need-kde 3

src_compile() {
	local myconf="--with-qhacc-config=/usr/bin"
	kde_src_compile all
}

pkg_postinst() {
	echo
	einfo "A sample configuration is provided in /usr/share/qhacc/easysetup."
	einfo "copy files: mkdir ~/.qhacc ; cp /usr/share/qhacc/easysetup/* ~/.qhacc"
	einfo "run program: khacc -f ~/.qhacc/"
	einfo "set alias: echo -e \\\n \"alias khacc=\\\"khacc -f ~/.qhacc\\\"\" >> ~/.bashrc"
	echo
}
