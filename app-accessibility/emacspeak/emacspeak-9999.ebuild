# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/emacspeak/emacspeak-9999.ebuild,v 1.3 2009/11/01 18:46:55 eva Exp $

EAPI="2"

inherit eutils
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"
inherit subversion

DESCRIPTION="the emacspeak audio desktop"
HOMEPAGE="http://emacspeak.sourceforge.net/"
SRC_URI=""
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+espeak"

DEPEND=">=virtual/emacs-22
	espeak? ( app-accessibility/espeak )"

RDEPEND="${DEPEND}
	>=dev-tcltk/tclx-8.4"

src_configure() {
	make config || die
}

src_compile() {
	make emacspeak || die
	if use espeak; then
		cd servers/linux-espeak
		make TCL_VERSION=8.5 || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README etc/NEWS* etc/FAQ etc/COPYRIGHT
	dohtml -r install-guide user-guide
	if use espeak; then
		cd servers/linux-espeak
		make DESTDIR="${D}" install
	fi
}
