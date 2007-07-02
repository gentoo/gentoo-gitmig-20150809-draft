# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-22.ebuild,v 1.4 2007/07/02 13:32:56 peper Exp $

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
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
	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
	sed -i -e "s@/.*image/@@" ${D}/usr/bin/emacspeak
}
