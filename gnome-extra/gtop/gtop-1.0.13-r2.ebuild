# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtop/gtop-1.0.13-r2.ebuild,v 1.3 2002/08/16 04:13:58 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPGAE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="( >=gnome-base/libgtop-1.0.12-r1
	 <gnome-base/libgtop-2.0.0 )
	>=gnome-base/gnome-libs-1.4.1.7
        nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    $myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

