# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portage-prefpane/portage-prefpane-0.3-r1.ebuild,v 1.1 2005/01/11 21:02:37 hansmi Exp $

inherit eutils

DESCRIPTION="A Preference-Pane for Mac OS X to configure portage"
SRC_URI="http://dev.gentoo.org/~hansmi/${P}.tar.bz2"
HOMEPAGE="http://dev.gentoo.org/~hansmi/"

KEYWORDS="~ppc-macos -*"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-autoconfig.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	mkdir -p "${D}/Library/PreferencePanes"
	cp -R Portage.prefPane "${D}/Library/PreferencePanes/"
}

