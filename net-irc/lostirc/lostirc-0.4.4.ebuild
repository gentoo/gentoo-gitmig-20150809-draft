# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.4.4.ebuild,v 1.2 2005/03/18 22:19:30 swegener Exp $

inherit base

IUSE="debug"
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

RDEPEND="=dev-cpp/gtkmm-2.4*
	>=dev-cpp/glibmm-2.4.4
	=dev-libs/libsigc++-2.0*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# Note: --enable-gnome installs the .desktop file in
	# /usr/share/applications, it does not add gnome dependencies
	# so, as this is the standard place, we should enable it always
	econf \
		--enable-gnome \
		--disable-kde \
		$(use_enable debug logdebug) \
		|| die "econf failed"
	base_src_compile make
}

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog README TODO NEWS || die "dodoc failed"
}
