# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.4.0.ebuild,v 1.3 2004/07/17 13:59:38 swegener Exp $

inherit base

IUSE="kde gnome debug"
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
#KEYWORDS="~sparc"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="=dev-cpp/gtkmm-2.4*
	=dev-cpp/glibmm-2.4*
	=dev-libs/libsigc++-2.0*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		`use_with gnome` \
		`use_with kde` \
		`use_enable debug logdebug` \
		|| die "econf failed"
	base_src_compile make
}

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
}
