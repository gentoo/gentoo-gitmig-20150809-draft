# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.10.ebuild,v 1.2 2001/05/27 02:58:36 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.helixcode.com"

DEPEND=">=gnome-base/gnome-core-1.2.4
	>=gnome-base/libunicode-0.4-r1
	>=gnome-base/gal-0.5
	>=gnome-base/gtkhtml-0.8.3
	ldap? ( >=net-nds/openldap-1.2 )"

src_compile() {

    local myconf
#    if [ "`use ldap`" ] ; then
#	myconf="--enable-ldap=yes"
#    else
	myconf="--enable-ldap=no"
#    fi
    try ./configure --prefix=/opt/gnome --host=${CHOST} --enable-file-locking=no $myconf
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


