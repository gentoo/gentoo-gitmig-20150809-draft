# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-icon-theme/xfce4-icon-theme-4.1.90.ebuild,v 1.1 2004/10/04 18:45:22 bcowan Exp $

IUSE=""
DESCRIPTION="Xfce 4 icon theme"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"
HOMEPAGE="http://xfce.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~mips"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	=xfce-base/libxfce4util-4.1.90
	=xfce-base/libxfcegui4-4.1.90
	=xfce-base/libxfce4mcs-4.1.90
	=xfce-base/xfce-mcs-manager-4.1.90
	=xfce-base/xffm-4.1.90"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!xfce-extra/xffm-icons"

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog*
}