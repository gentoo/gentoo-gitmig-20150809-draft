# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-0.17-r1.ebuild,v 1.1 2001/10/06 10:45:50 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libglade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.15"
#	 bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myopts

# Bonobo support creates a circular depend // Hallski
#	if [ "`use bonobo`" ]
#	then
#		myconf="--enable-bonobo --disable-bonobotest"
#	else
#		myconf="--disable-bonobo"
#	fi

	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
	            --disable-gnomedb					\
		    --disable-bonobo --disable-bonobotest ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS
	dodoc doc/*.txt
}
