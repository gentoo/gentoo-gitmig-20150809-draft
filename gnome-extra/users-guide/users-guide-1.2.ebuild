# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/users-guide/users-guide-1.2.ebuild,v 1.12 2002/08/16 04:14:00 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"
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
