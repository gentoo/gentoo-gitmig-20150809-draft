# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-0.5.17.ebuild,v 1.3 2004/11/04 08:22:19 obz Exp $

inherit gnome.org libtool gnuconfig

IUSE=""

MY_P="ORBit-${PV}"
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
HOMEPAGE="http://www.labs.redhat.com/orbit/"
SRC_URI="mirror://gnome/sources/ORBit/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

DEPEND="sys-devel/gettext
	>=sys-apps/tcp-wrappers-7.6
	=dev-libs/glib-1.2*"

RDEPEND="=dev-libs/glib-1.2*"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha mips hppa amd64 ppc ia64 ppc64"

src_compile() {
	# Detect mips systems properly
	gnuconfig_update

	# Libtoolize to fix "relink bug" in older libtool's distributed
	# with packages.
	elibtoolize

	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		|| die

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
