# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-18.ebuild,v 1.6 2004/10/05 10:33:48 pvdabeel Exp $

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/emacs
	>=dev-tcltk/tclx-8.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7"

S=${WORKDIR}/${P}.0

src_compile() {
	make config SRC=`pwd` || die
	make emacspeak || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die

	sed -i -e "s@/.*image/@@" ${D}/usr/bin/emacspeak

	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
}
