# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-office/gnumeric/gnumeric-0.66.ebuild,v 1.1 2001/06/28 09:47:57 hallski Exp
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-0.70-r2.ebuild,v 1.1 2001/10/06 20:15:36 hallski Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnumeric"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnumeric/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"

RDEPEND=">=gnome-base/gnome-print-0.30
        >=gnome-extra/gal-0.13-r1
        >=dev-libs/libxml-1.8.15
	>=dev-libs/libole2-0.2.3-r1
        perl? ( >=sys-devel/perl-5 )
	python? ( >=dev-lang/python-2.0 )
        gb? ( >=gnome-extra/gb-0.0.20-r1 )
        libgda? ( >=gnome-extra/libgda-0.2.91 )
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 ) "

DEPEND="${RDEPEND}
        >=dev-util/xml-i18n-tools-0.8.4
        nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	patch -p0 < ${FILESDIR}/${P}-gdk-gc-ref.patch
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
}

src_compile() {
	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi
	if [ -z "`use bonobo`" ] ; then
		myconf="$myconf --without-bonobo"
  	fi
  	if [ "`use gb`" ]; then
    		#does not work atm
    		myconf="$myconf --without-gb"
  	else
    		myconf="$myconf --without-gb"
  	fi
  	if [ "`use perl`" ]; then
    		myconf="$myconf --with-perl"
  	else
    		myconf="$myconf --without-perl"
  	fi
  	if [ "`use python`" ]; then
    		myconf="$myconf --with-python"
  	else
    		myconf="$myconf --without-python"
  	fi
  	if [ "`use libgda`" ]; then
    		myconf="$myconf --with-gda"
  	else
    		myconf="$myconf --without-gda"
  	fi

  	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    ${myconf} || die

	emake || die "Building of package failed."
}

src_install() {
  	make DESTDIR=${D} install || die

  	dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO
}

