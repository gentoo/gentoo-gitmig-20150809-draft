# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/users-guide/users-guide-1.2.ebuild,v 1.18 2004/07/14 16:00:50 agriffis Exp $

DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""
LICENSE="GPL-2"
DEPEND="gnome-base/gnome-core"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README* TODO
}
