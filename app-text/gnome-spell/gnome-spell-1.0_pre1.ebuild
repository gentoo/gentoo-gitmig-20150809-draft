# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jesse <jesse@dowellcompany.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0_pre1.ebuild,v 1.2 2002/05/23 02:02:12 spider Exp $

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gnome spellchecking component."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gnome-spell/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnome.org"

DEPEND="virtual/glibc
	>=gnome-base/libbonoboui-1.113.0
	>=gnome-base/libgnomeui-1.114.0
	>=gnome-base/libglade-1.99.9
	>=app-text/pspell-0.12.2"
#	>=app-text/pspell-ispell-0.12-r1
#	nls? ( sys-devel/gettext )"

src_compile() {

	libtoolize --copy --force

	local myconf=""
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	./configure 	\
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
