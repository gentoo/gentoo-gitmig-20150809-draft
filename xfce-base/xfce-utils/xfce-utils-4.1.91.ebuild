# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.1.91.ebuild,v 1.2 2004/11/04 23:26:20 vapier Exp $

DESCRIPTION="Xfce 4 utilities"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtkhtml"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	gtkhtml? ( gnome-extra/libgtkhtml )
	=xfce-base/libxfce4util-${PV}
	=xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}
	=xfce-base/xfce-mcs-manager-${PV}
	>=dev-libs/dbh-1.0.20"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
	    `use_enable gtkhtml` \
	    --enable-gdm || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog* AUTHORS README* TODO* NEWS INSTALL
}
