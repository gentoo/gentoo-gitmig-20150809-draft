# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm/gtkmm-1.3.22.ebuild,v 1.1 2002/09/13 13:45:41 spider Exp $

# we want debug on the unstable branch
inherit debug

S=${WORKDIR}/${P}
DESCRIPTION="C++ interface for GTK+"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

SLOT="2"
DEPEND="virtual/glibc
	>=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	sys-devel/perl
	>=dev-libs/libsigc++-1.1.13"

RDEPEND=${DEPEND}

src_compile() {
	local myconf
	
	if [ "${DEBUG}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
	
  	./configure --host=${CHOST}			\
		--prefix=/usr				\
		--infodir=/usr/share/info		\
		--mandir=/usr/share/man			\
		--sysconfdir=/etc/X11			\
		--with-xinput=xfree			\
		--with-x				\
		${myconf} || die "configure failure"
		
	emake || die "emake failure."
}

src_install() {

	make DESTDIR=${D} \
		install || die "make install failure"


	dodoc AUTHORS COPYING ChangeLog* HACKING
	dodoc NEWS* README* TODO
}




