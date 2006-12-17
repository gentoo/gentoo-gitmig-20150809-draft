# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-25.ebuild,v 1.1 2006/12/17 17:57:37 williamh Exp $

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.bz2"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/emacs
	>=dev-tcltk/tclx-8.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}

src_compile() {
	make config SRC=`pwd` || die
	make emacspeak || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
	dosed "s:/.*image/::" /usr/bin/emacspeak
}
