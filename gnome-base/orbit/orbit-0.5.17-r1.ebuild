# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-0.5.17-r1.ebuild,v 1.11 2006/07/05 05:38:36 vapier Exp $

inherit gnome.org libtool eutils multilib

MY_P="ORBit-${PV}"
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high-performance, lightweight CORBA ORB aiming for CORBA 2.2 compliance"
HOMEPAGE="http://www.labs.redhat.com/orbit/"
SRC_URI="mirror://gnome/sources/ORBit/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
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
	# Libtoolize to fix "relink bug" in older libtool's distributed
	# with packages.
	elibtoolize
}

src_compile() {
	econf \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		|| die

	make || die # Doesn't work with -j 4 (hallski)
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog README NEWS TODO
	dodoc docs/*.txt docs/IDEA1

	docinto idl
	cd libIDL
	dodoc AUTHORS BUGS NEWS README*

	docinto popt
	cd ../popt
	dodoc CHANGES README

	sed -i \
		-e 's:-I/usr/include":-I/usr/include/libIDL-1.0":' \
		"${D}"/usr/$(get_libdir)/libIDLConf.sh || die
}
