# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.1.11-r3.ebuild,v 1.1 2002/06/11 23:52:07 spider Exp $

inherit gnome2

MY_PN=GConf
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Gnome Configuration System and Daemon"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${MY_PN}/${MY_PN}-${PV}.tar.bz2 ftp://archive.progeny.com/GNOME/pre-gnome2/sources/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"

RDEPEND=">=dev-libs/glib-2.0.1
		>=gnome-base/ORBit2-2.3.106
		>=dev-libs/libxml2-2.4.17
		>=net-libs/linc-0.1.19"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

LIBTOOL_FIX="1"

pkg_preinst () {
	# hack hack
	dodir /etc/gconf/gconf.xml.mandatory
	dodir /etc/gconf/gconf.xml.defaults
    touch ${D}/etc/gconf/gconf.xml.mandatory/.keep
	touch ${D}/etc/gconf/gconf.xml.defaults/.keep
		
}
DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"


