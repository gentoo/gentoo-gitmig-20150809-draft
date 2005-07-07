# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.4.6.ebuild,v 1.2 2005/07/07 15:51:47 swegener Exp $

inherit base

IUSE="debug nls"
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.4.4
	=dev-libs/libsigc++-2.0*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		--enable-desktopfile \
		$(use_enable debug logdebug) \
		$(use_enable nls) \
		|| die "econf failed"
	base_src_compile make
}

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
}
