# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-office/gnumeric/gnumeric-0.66.ebuild,v 1.1 2001/06/28 09:47:57 hallski Exp
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-0.75.ebuild,v 1.2 2001/11/10 03:03:57 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

# We actually need guile-1.5
RDEPEND=">=x11-libs/gtk+-1.2.10-r3
	 >=gnome-base/gnome-libs-1.4.1.2-r1
	 >=gnome-base/oaf-0.6.7
	 >=gnome-base/ORBit-0.5.11
	 >=gnome-base/libglade-0.17
	 >=gnome-base/gnome-print-0.31
         >=gnome-extra/gal-0.14
         >=dev-libs/libxml-1.8.16
	 >=dev-libs/libole2-0.2.4
         perl?	 ( >=sys-devel/perl-5 )
	 python? ( >=dev-lang/python-2.0 )
         gb?	 ( >=gnome-extra/gb-0.0.20-r1 )
	 guile?	 ( >=dev-util/guile-1.4 )
         libgda? ( >=gnome-extra/libgda-0.2.91 )
	 bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )
	 evo?	 ( >=net-mail/evolution-0.13 )"

DEPEND="${RDEPEND}
        >=dev-util/intltool-0.11
        nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi
	if [ -z "`use bonobo`" ] ; then
		myconf="${myconf} --without-bonobo"
  	fi
  	if [ "`use gb`" ]; then
    		#does not work atm
    		myconf="${myconf} --without-gb"
  	else
    		myconf="${myconf} --without-gb"
  	fi
	if [ "`use guile`"]; then
		myconf="${myconf} --with-guile"
	else
		myconf="${myconf} --without-guile"
	fi
  	if [ "`use perl`" ]; then
    		myconf="${myconf} --with-perl"
  	else
    		myconf="${myconf} --without-perl"
  	fi
  	if [ "`use python`" ]; then
    		myconf="${myconf} --with-python"
  	else
    		myconf="${myconf} --without-python"
  	fi
  	if [ "`use libgda`" ]; then
    		myconf="${myconf} --with-gda"
  	else
    		myconf="${myconf} --without-gda"
  	fi
	if [ "`use evo`" ]; then
		myconf="${myconf} --with-evolution"
	fi

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"

  	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    ${myconf} || die

	emake || die "Building of package failed."
}

src_install() {

  	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     install || die

  	dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO
}

