# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfire/wmfire-0.0.3.9_pre4.ebuild,v 1.3 2003/02/13 17:29:16 vapier Exp $

IUSE=""

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="WindowMaker dockapp that displays cpu usage as a dancing flame"
SRC_URI="http://staff.xmms.org/zinx/misc/${MY_P}.tar.gz"
HOMEPAGE="http://staff.xmms.org/zinx/misc"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf="--with-x";
	econf ${myconf} || die "configure failed"

	emake CFLAGS="$CFLAGS"  || die "parallel make faile"
}

src_install () {

	make install \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib || die

	dodoc AUTHORS COPYING CREDITS INSTALL NEWS README

}
