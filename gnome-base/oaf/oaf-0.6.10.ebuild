# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.10.ebuild,v 1.19 2004/11/05 22:29:28 corsair Exp $

IUSE="nls"

inherit gnome.org libtool gnuconfig

DESCRIPTION="Object Activation Framework for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ~ppc64"

RDEPEND="virtual/libc
	>=dev-libs/popt-1.5
	=gnome-base/orbit-0*
	>=dev-libs/libxml-1.8.15"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/indent
	nls? ( sys-devel/gettext )"

src_compile() {
	elibtoolize

	use ppc64 && gnuconfig_update

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
