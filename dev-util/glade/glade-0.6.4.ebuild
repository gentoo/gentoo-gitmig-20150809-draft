# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.6.4.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="glade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/${P}.tar.gz"
HOMEPAGE="http://glade.gnome.org/"

RDEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext 
	>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myopts

	if [ -z "`use gnome`" ]
	then
		myopts="--disable-gnome"
	fi

	if [ "`use bonobo`" ]
	then
		myopts="$myopts --with-bonobo"
	else
		myopts="$myopts --without-bonobo"
	fi

	if [ -z "`use nls`" ]
	then
		myopts="$myopts --disable-nls"
	fi

	if [ "$DEBUG" ]
	then
		myopts="$myopts --enable-debug"
	fi

	./configure --host=${CHOST} 					\
		--prefix=/usr					\
		--sysconfdir=/etc					\
		--disable-gnome-db 					\
		${myopts}  || die

	emake || die
}

src_install() {
	make prefix=${D}/usr 						\
		sysconfdir=${D}/etc 					\
		install || die

	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
