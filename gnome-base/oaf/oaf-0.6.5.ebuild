# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/oaf/oaf-0.6.5.ebuild,v 1.8 2001/08/31 22:35:07 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Object Activation Framework for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"

RDEPEND="virtual/glibc
        >=dev-libs/popt-1.5
	>=gnome-base/gnome-env-1.0
	>=gnome-base/ORBit-0.5.8
	>=gnome-base/libxml-1.8.11"

DEPEND="${RDEPEND}
	>=sys-devel/perl-5
        nls? ( sys-devel/gettext )"


src_unpack() {
	unpack ${A}

	cd ${S}
	cp -a configure configure.orig
	sed -e "s:perl5\.00404:perl5.6.1:" configure.orig > configure
	rm configure.orig
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
		    --sysconfdir=/etc/opt/gnome 			\
		    --datadir=/opt/gnome/share 				\
		    --mandir=/opt/gnome/man ${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS TODO
}

pkg_postinst() {
	ldconfig -r ${ROOT}
}
