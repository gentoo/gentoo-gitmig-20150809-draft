# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.0.4.ebuild,v 1.6 2004/04/05 12:50:36 gmsoft Exp $

IUSE="xinerama X"
S=${WORKDIR}/${P}

DESCRIPTION="Libraries for XFCE4"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~ia64 x86 ~ppc ~alpha sparc ~amd64 hppa ~mips"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	=xfce-base/libxfce4util-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf
	myconf=""

	use xinerama && myconf="${myconf} --enable-xinerama"
	use X && myconf="${myconf} --with-x"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README ChangeLog
}
