# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.13.ebuild,v 1.2 2001/09/08 15:16:18 agriffis Exp $

DB3=db-3.1.17
A="${P}.tar.gz ${DB3}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.ximian.com/pub/source/${PN}/${A}
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
	 http://www.sleepycat.com/update/3.1.17/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

DEPEND=">=gnome-base/gal-0.11.2
        >=gnome-base/gconf-1.0.4
	>=gnome-base/gtkhtml-0.12
	>=gnome-libs/bonobo-conf-0.11
	>=gnome-base/bonobo-1.0.8
	>=gnome-base/oaf-0.6.6
	>=gnome-base/ORBit-0.5.8
	>=gnome-base/libglade-0.14
	>=media-libs/gdk-pixbuf-0.9.0
	>=gnome-base/libxml-1.8.15
	>=gnome-base/gnome-vfs-1.0
	>=gnome-base/gnome-print-0.25
        >=dev-util/xml-i18n-tools-0.8.4
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )" 

src_compile() {

    cd ${WORKDIR}/${DB3}/build_unix
    try ../dist/configure --prefix=${WORKDIR}/db3
    try make # make -j 4 doesn't work, use make
    try make prefix=${WORKDIR}/db3 install

    cd ${S}
  
    local myconf

    if [ "`use ssl`" ] ; then
      myconf="$myconf --enable-ssl"
    else
      myconf="$myconf --disable-ssl"
    fi

    try ./configure --prefix=/opt/gnome --host=${CHOST} \
	--sysconfdir=/etc/opt/gnome --enable-file-locking=no \
	--with-db3=${WORKDIR}/db3 --enable-nntp $myconf

    make || die # emake didn't work.
}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


