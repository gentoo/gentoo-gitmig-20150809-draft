# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnofin/gnofin-0.8.4.ebuild,v 1.16 2005/01/01 14:38:54 weeve Exp $

inherit gnuconfig

DESCRIPTION="a personal finance application for GNOME"
HOMEPAGE="http://gnofin.sourceforge.net"
SRC_URI="ftp://gnofin.sourceforge.net/pub/gnofin/stable/source/${P}.tar.gz
	 http://download.sourceforge.net/gnofin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc"
IUSE=""

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-libs/libxml-1.8.10"

src_compile() {
	gnuconfig_update

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib || die
	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}
