# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>, Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/evolution/evolution-0.14.ebuild,v 1.1 2001/09/26 23:46:39 azarah Exp $

DB3=db-3.1.17
A="${P}.tar.gz ${DB3}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.ximian.com/pub/source/${PN}/${A}
	 ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
	 http://www.sleepycat.com/update/3.1.17/${DB3}.tar.gz"
HOMEPAGE="http://www.ximian.com"

# Fixed bonobo-conf, gal, gtkhtml order as specified in Evolution README 
# (really needed?)
DEPEND=">=gnome-libs/bonobo-conf-0.11
        >=gnome-base/bonobo-1.0.8
	>=gnome-base/gal-0.12
        >=gnome-base/gconf-1.0.4
	>=gnome-base/gtkhtml-0.13
	>=gnome-base/oaf-0.6.6
	>=gnome-base/ORBit-0.5.8
	>=gnome-base/libglade-0.14
	>=media-libs/gdk-pixbuf-0.9.0
	>=gnome-base/libxml-1.8.15
	>=gnome-base/gnome-vfs-1.0
	>=gnome-base/gnome-print-0.25
	>=gnome-base/scrollkeeper-0.2
        >=dev-util/xml-i18n-tools-0.8.4
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	mozilla? ( net-www/mozilla )" 

src_compile() {

    cd ${WORKDIR}/${DB3}/build_unix
    ../dist/configure --prefix=${WORKDIR}/db3 || die
    make || die # make -j 4 doesn't work, use make
    make prefix=${WORKDIR}/db3 install || die

    cd ${S}
  
    local myconf
    MOZILLA=$MOZILLA_FIVE_HOME
    use ssl      && myconf="$myconf --enable-ssl"
    use ssl      || myconf="$myconf --disable-ssl"
    use mozilla  && myconf="$myconf --with-nspr-includes=${MOZILLA}/include/nspr" \
    		 && myconf="$myconf --with-nss-includes=${MOZILLA}/include" \
    		 && myconf="$myconf --with-nspr-libs=${MOZILLA}" 

    ./configure --prefix=/opt/gnome --host=${CHOST} \
	--sysconfdir=/etc/opt/gnome --enable-file-locking=no \
	--with-db3=${WORKDIR}/db3 --without-movemail --enable-nntp $myconf || die

    make || die # emake didn't work.
}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


