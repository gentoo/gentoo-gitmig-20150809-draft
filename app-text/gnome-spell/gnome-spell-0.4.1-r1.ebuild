# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jesse <jesse@dowellcompany.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-0.4.1-r1.ebuild,v 1.1 2002/04/04 08:09:15 seemant Exp $

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gnome spellchecking component."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gnome-spell/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnome.org"

DEPEND="virtual/glibc
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=app-text/pspell-ispell-0.12-r1
	gnome?( >=gnome-base/gnome-core-1.4.0.4-r1 )
	nls? ( sys-devel/gettext )"

src_compile() {

	libtoolize --copy --force

	local myconf
	
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	use gnome || myconf="${myconf} --without-gnome"

	./configure 	\
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
