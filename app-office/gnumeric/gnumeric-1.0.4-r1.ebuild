# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.0.4-r1.ebuild,v 1.3 2002/05/23 06:50:10 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

#Eye Of Gnome (media-gfx/eog) is for image support.
RDEPEND="=x11-libs/gtk+-1.2*
	 >=gnome-base/gnome-libs-1.4.1.2-r1
	 >=gnome-base/oaf-0.6.7
	 >=gnome-base/ORBit-0.5.12-r1
	 >=gnome-base/libglade-0.17
	 >=gnome-base/gnome-print-0.31
	 >=gnome-extra/gal-0.18
	 >=dev-libs/libxml-1.8.16
	 >=dev-libs/libole2-0.2.4
	 >=gnome-base/bonobo-1.0.17
	 >=media-gfx/eog-0.6
	 ~media-libs/freetype-1.3.1
	 perl?	 ( >=sys-devel/perl-5 )
	 python? ( >=dev-lang/python-2.0 )
	 gb?	 ( ~gnome-extra/gb-0.0.17 )
	 guile?	 ( >=dev-util/guile-1.5 )
	 libgda? ( >=gnome-extra/libgda-0.2.91 )
	 evo?	 ( >=net-mail/evolution-0.13 )"

DEPEND="${RDEPEND}
	 >=dev-util/intltool-0.11
	 nls? ( sys-devel/gettext )"


src_compile() {

	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi
  	if [ "`use gb`" ]; then
    		myconf="${myconf} --with-gb"
  	else
    		myconf="${myconf} --without-gb"
  	fi
	if [ "`use guile`" ]; then
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

  	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --with-bonobo \
		    ${myconf} || die

	emake || make || die
}

src_install() {

  	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     install || die

  	dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO
}

