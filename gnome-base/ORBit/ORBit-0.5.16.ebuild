# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit/ORBit-0.5.16.ebuild,v 1.16 2004/07/14 15:20:51 agriffis Exp $

inherit gnome.org

IUSE="nls"

DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
HOMEPAGE="http://www.labs.redhat.com/orbit/"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	>=sys-apps/tcp-wrappers-7.6
	=dev-libs/glib-1.2*"

RDEPEND="virtual/libc
	=dev-libs/glib-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

src_compile() {
	if ! use nls ; then
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
