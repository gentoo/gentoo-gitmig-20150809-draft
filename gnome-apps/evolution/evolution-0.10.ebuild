# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.10.ebuild,v 1.5 2001/07/29 10:39:39 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.helixcode.com"

DEPEND="=gnome-base/gal-0.7 
        nls? ( sys-devel/gettext )
	>=gnome-base/gtkhtml-0.8.3
        >=dev-util/xml-i18n-tools-0.8.4"
        #mozilla? ( >=net-www/mozilla-0.9 )"
	#ldap? ( >=net-nds/openldap-1.2 )"

RDEPEND="=gnome-base/gal-0.7
	>=gnome-base/gtkhtml-0.8.3"
        #mozilla? ( >=net-www/mozilla-0.9 )"
	#ldap? ( >=net-nds/openldap-1.2 )"

src_compile() {

    local myconf
#    if [ "`use ldap`" ] ; then
#	myconf="--enable-ldap=yes"
#    else
	myconf="--enable-ldap=no"
#    fi
if [ "`use mozilla`" ]
  then
    # mozilla does not really work cuz of a missing libnss
    MOZILLA=/opt/mozilla
    #myconf="${myconf} --with-nspr-libs=$MOZILLA \
	#	--with-nspr-includes=$MOZILLA/include/nspr"
    #export MOZILLA_FIVE_HOME=$MOZILLA
    #export LD_LIBRARY_PATH=$MOZILLA_FIVE_HOME
  fi
    try ./configure --prefix=/opt/gnome --host=${CHOST} --enable-file-locking=no $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


