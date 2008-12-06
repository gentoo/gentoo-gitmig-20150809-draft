# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xfwm4-themes/xfwm4-themes-4.4.3.ebuild,v 1.3 2008/12/06 19:44:32 darkside Exp $

DESCRIPTION="Window manager decorations & themes for Xfce4"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://xfce/xfce-${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="binchecks strip"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
