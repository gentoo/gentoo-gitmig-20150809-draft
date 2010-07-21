# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bblaunch/bblaunch-0.0.3.ebuild,v 1.12 2010/07/21 14:30:54 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="An application launcher for Blackbox type window managers"
SRC_URI="http://www.stud.ifi.uio.no/~steingrd/${P}.tar.gz"
HOMEPAGE="http://blackboxwm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/blackbox"

src_prepare() {
	epatch "${FILESDIR}"/${P}.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README CHANGELOG AUTHORS
}
