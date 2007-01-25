# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/khacc/khacc-3.2.1.ebuild,v 1.7 2007/01/25 05:18:13 genone Exp $

inherit kde eutils

DESCRIPTION="KDE personal accounting system based on QHacc."
HOMEPAGE="http://qhacc.sourceforge.net"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

SLOT="0"
KEYWORDS="x86 sparc ppc"
LICENSE="GPL-2"
IUSE=""


DEPEND="~app-office/qhacc-${PV}"
RDEPEND="~app-office/qhacc-${PV}"
need-kde 3

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}.diff
}

src_compile() {
	local myconf="--with-qhacc-config=/usr/bin"
	kde_src_compile
}

pkg_postinst() {
	echo
	elog "A sample configuration is provided in /usr/share/qhacc/easysetup."
	elog "copy files: \`mkdir ~/.qhacc ; cp /usr/share/qhacc/easysetup/* ~/.qhacc\`"
	elog "run program: \`khacc -f ~/.qhacc/\`"
	elog "set alias: \`echo -e \\\n \"alias khacc=\\\"khacc -f ~/.qhacc\\\"\" >> ~/.bashrc\`"
	echo
}

