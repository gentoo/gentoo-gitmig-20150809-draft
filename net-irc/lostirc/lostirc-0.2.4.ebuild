# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.2.4.ebuild,v 1.5 2003/09/11 01:23:41 msterret Exp $

inherit base

IUSE=""
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
S=${WORKDIR}/${P}
DEPEND=">=dev-cpp/gtkmm-2.0*
	=dev-libs/libsigc++-1.2*"

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO NEWS
}
