# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/slmon/slmon-0.5.12.ebuild,v 1.1 2003/01/08 20:07:21 blizzy Exp $

DESCRIPTION="Colored text-based system performance monitor"
HOMEPAGE="http://slmon.sourceforge.net/"
# mirror://sourceforge/slmon/... is out of date
SRC_URI="http://slmon.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="gnome-base/libgtop
	sys-libs/slang"

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	einstall || die "install problem"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
