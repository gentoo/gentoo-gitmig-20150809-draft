# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnomemm/gnomemm-1.2.4.ebuild,v 1.7 2006/07/13 01:10:24 pvdabeel Exp $

inherit toolchain-funcs eutils

DESCRIPTION="C++ binding for the GNOME libraries"
SRC_URI="mirror://gnome/sources/gnomemm/1.2/${P}.tar.bz2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86 sparc alpha hppa amd64 ia64"

DEPEND="=dev-cpp/gtkmm-1.2*
	>=gnome-base/gnome-libs-1.4
	=gnome-base/orbit-0*
	=sys-libs/db-1*"


src_unpack() {
	unpack ${A} ; cd ${S}
	# http://bugzilla.gnome.org/show_bug.cgi?id=121307 gcc 3.3.x (#27061)
	epatch "${FILESDIR}"/${P}-gcc33.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}
