# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="ee"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	nls? ( sys-devel/gettext )"


RDEPEND=$DEPEND
src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PN}-mo.diff
}

src_compile() {
	local myconf
	use nls && myconf="--enable-nls" || myconf="--disable-nls" 
	
	econf ${myconf} || die "configure failure" 
	emake || die "make failure"
}

src_install() {
	make DESTDIR=${D} \
	     prefix=/usr \
	     install || die "make install failure"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
