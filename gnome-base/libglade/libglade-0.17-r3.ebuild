# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-0.17-r3.ebuild,v 1.1 2001/12/13 18:19:02 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libglade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=dev-libs/libxml-1.8.15
	 >=gnome-base/gnome-libs-1.4.1.2-r1
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
		    --sysconfdir=/etc					\
	  	    --localstatedir=/var/lib				\
	            --disable-gnomedb					\
		    --disable-bonobo --disable-bonobotest		\
	 	    ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS
	dodoc doc/*.txt
}
