# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.0.4.ebuild,v 1.5 2004/04/05 13:57:50 gmsoft Exp $

IUSE="X gtkhtml gnome"
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 utilities"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 x86 ~ppc ~alpha sparc ~amd64 hppa ~mips"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	=xfce-base/libxfce4util-${PV}
	=xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}
	=xfce-base/xfce-mcs-manager-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf
	myconf=""

	use X && myconf="${myconf} --with-x"
	use gtkhtml && myconf="${myconf} --enable-gtkhtml"
	use gnome && myconf="${myconf} --enable-gdm"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
