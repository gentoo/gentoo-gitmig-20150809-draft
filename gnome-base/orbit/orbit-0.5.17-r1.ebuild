# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-0.5.17-r1.ebuild,v 1.9 2006/03/16 18:46:14 foser Exp $

inherit gnome.org libtool gnuconfig eutils multilib

MY_P="ORBit-${PV}"
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
HOMEPAGE="http://www.labs.redhat.com/orbit/"
SRC_URI="mirror://gnome/sources/ORBit/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-devel/gettext
		>=sys-apps/tcp-wrappers-7.6
		=dev-libs/glib-1.2*"
RDEPEND="=dev-libs/glib-1.2*
	dev-util/indent"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-rpath-security-fix.patch
	gnuconfig_update
	# Libtoolize to fix "relink bug" in older libtool's distributed
	# with packages.
	elibtoolize
}

src_compile() {
	econf \
		--host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		|| die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	#make prefix=${D}/usr \
	#	libdir=${D}/usr/$(get_libdir) \
	#	sysconfdir=${D}/etc \
	#	infodir=${D}/usr/share/info \
	#	localstatedir=${D}/var/lib \
	#	install || die
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog README NEWS TODO
	dodoc docs/*.txt docs/IDEA1

	docinto idl
	cd libIDL
	dodoc AUTHORS BUGS NEWS README*

	docinto popt
	cd ../popt
	dodoc CHANGES README

	sed -i -e 's:-I/usr/include":-I/usr/include/libIDL-1.0":' \
		${D}/usr/$(get_libdir)/libIDLConf.sh || die
}
