# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.14-r2.ebuild,v 1.4 2002/07/17 10:13:15 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.labs.redhat.com/orbit/"

DEPEND="virtual/glibc 
	nls? ( sys-devel/gettext )
	>=sys-apps/tcp-wrappers-7.6
	=dev-libs/glib-1.2*"

RDEPEND="virtual/glibc 
	=dev-libs/glib-1.2*"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	# Libtoolize to fix "relink bug" in older libtool's distributed
	# with packages.
	libtoolize --copy --force
	cd popt
	libtoolize --copy --force
	cd ../libIDL
	libtoolize --copy --force
	cd ${S}

	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		$myconf || die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	dodoc docs/*.txt docs/IDEA1

	docinto idl
	cd libIDL
	dodoc AUTHORS BUGS COPYING NEWS README*

	docinto popt
	cd ../popt
	dodoc CHANGES COPYING README

	cd ${D}/usr/lib
	patch -p0 < ${FILESDIR}/libIDLConf.sh-gentoo.diff
}

