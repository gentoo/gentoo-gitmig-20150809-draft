# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.10.ebuild,v 1.13 2004/01/10 03:03:18 agriffis Exp $

IUSE="nls"

inherit gnome.org libtool

S=${WORKDIR}/${P}
DESCRIPTION="Object Activation Framework for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

RDEPEND="virtual/glibc
	>=dev-libs/popt-1.5
	>=gnome-base/ORBit-0.5.10-r1
	>=dev-libs/libxml-1.8.15"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/indent
	nls? ( sys-devel/gettext )"

src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS TODO
}

