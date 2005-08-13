# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.18.ebuild,v 1.5 2005/08/13 23:39:41 hansmi Exp $

inherit kde

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.kde.org/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="nls"

need-kde 3

src_install() {
	kde_src_install
	use nls || rm -rf "${D}"/usr/share/locale
}
