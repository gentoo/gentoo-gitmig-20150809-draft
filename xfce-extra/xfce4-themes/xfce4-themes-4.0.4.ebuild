# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-themes/xfce4-themes-4.0.4.ebuild,v 1.3 2004/03/17 00:52:50 gustavoz Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 themes"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 x86 ~ppc ~alpha sparc ~amd64 ~hppa ~mips"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	>=xfce-base/xfce4-base-${PV}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL COPYING README ChangeLog TODO
}
