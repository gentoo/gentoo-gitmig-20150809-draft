# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.1.99.1.ebuild,v 1.2 2004/12/01 06:17:03 bcowan Exp $

DESCRIPTION="Libraries for Xfce 4"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	x11-libs/startup-notification
	>=dev-libs/dbh-1.0.20
	=xfce-base/libxfce4util-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
	    `use_enable xinerama` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog* AUTHORS README*
}
