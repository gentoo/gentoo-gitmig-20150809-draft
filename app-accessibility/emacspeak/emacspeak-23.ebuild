# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-23.ebuild,v 1.1 2006/01/01 01:56:54 williamh Exp $

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.0.tar.bz2"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/emacs
	>=dev-tcltk/tclx-8.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${P}.505

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
