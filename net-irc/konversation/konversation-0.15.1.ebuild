# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.15.1.ebuild,v 1.4 2005/02/24 01:24:20 malc Exp $

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.sourceforge.net/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 ~sparc"
IUSE="nls"

need-kde 3

src_install() {
	kde_src_install
	use nls || rm -rf ${D}/usr/share/locale
}
