# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/glibwww/glibwww-0.2-r2.ebuild,v 1.13 2004/07/14 15:25:01 agriffis Exp $

DESCRIPTION="The Gnome WWW Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""
LICENSE="GPL-2"

DEPEND=">=net-libs/libwww-1.5.3-r1
	 >=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr	\
		    --sysconfdir=/etc	\
		    --localstatedir=/var/lib \
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib	\
	     install || die

	dodoc AUTHORS ChangeLog NEWS README
}
