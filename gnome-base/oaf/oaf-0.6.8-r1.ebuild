# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.8-r1.ebuild,v 1.4 2002/07/19 13:33:50 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Object Activation Framework for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

RDEPEND="virtual/glibc
	>=dev-libs/popt-1.5
	>=gnome-base/ORBit-0.5.10-r1
	>=dev-libs/libxml-1.8.15"

DEPEND="${RDEPEND}
	>=sys-devel/perl-5
	dev-util/indent
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp -a configure configure.orig
	sed -e "s:perl5\.00404:perl5.6.1:" configure.orig > configure
	rm configure.orig
}

src_compile() {
	libtoolize --copy --force
	
	local myconf=""
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

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

pkg_postinst() {
	ldconfig -r ${ROOT}
}

