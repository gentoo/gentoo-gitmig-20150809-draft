# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfwm4/xfwm4-4.0.3.1.ebuild,v 1.1 2004/01/25 22:11:20 bcowan Exp $

IUSE="X"
S=${WORKDIR}/${P}
XV="4.0.3"

DESCRIPTION="Xfce4 windowmanager"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	=xfce-base/libxfce4util-${XV}
	=xfce-base/libxfcegui4-${XV}
	=xfce-base/libxfce4mcs-${XV}
	=xfce-base/xfce-mcs-manager-${XV}
	x11-libs/startup-notification"

src_compile() {
	local myconf
	myconf=""

	use X && myconf="${myconf} --with-x"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
