# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-1.2.9.ebuild,v 1.11 2002/12/09 04:41:47 manson Exp $

DESCRIPTION="C++ interface for GTK+"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	>=dev-libs/libsigc++-1.0.4"

src_compile() {
	local myconf
	
	if [ "${DEBUGBUILD}" ] ; then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
	
	econf --with-xinput=xfree \
		--with-x \
		${myconf}

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* HACKING NEWS* README* TODO
}
