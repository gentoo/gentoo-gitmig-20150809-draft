# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.2.5.ebuild,v 1.3 2003/05/14 09:26:31 jje Exp $

inherit base

IUSE=""
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}/${P}
DEPEND=">=x11-libs/gtkmm-2.0
        >=dev-libs/libsigc++-1.2"

src_install() {
        base_src_install
        dodoc AUTHORS ChangeLog COPYING INSTALL README TODO NEWS
}

