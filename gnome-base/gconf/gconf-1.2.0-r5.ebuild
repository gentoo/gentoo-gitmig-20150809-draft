# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.2.0-r5.ebuild,v 1.3 2002/09/05 21:34:47 spider Exp $

inherit gnome2

MY_PN=GConf
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Gnome Configuration System and Daemon"
SRC_URI="mirror://gnome/2.0.0/sources/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=">=dev-libs/glib-2.0.1
		>=gnome-base/ORBit2-2.4.0
		>=dev-libs/libxml2-2.4.17
		>=net-libs/linc-0.5.0
		>=x11-libs/gtk+-2.0.5"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc )"

LIBTOOL_FIX="1"

# This should fix weird sandbox violations when we call `kill_gconf' and
# directories like /etc/gconf/gconf.xml.mandatory and /root/.gconfd are
# not present
addwrite "/etc/gconf:/root"

kill_gconf () {
	# this function will kill all running gconfd that could be causing troubles
	if [ -x /usr/bin/gconftool ]
	then
		/usr/bin/gconftool --shutdown 
	fi
	if [ -x /usr/bin/gconftool-1 ]
	then
		/usr/bin/gconftool-1 --shutdown
	fi

	# and for gconf 2
	if [ -x /usr/bin/gconftool-2 ]
	then
		/usr/bin/gconftool-2 --shutdown
	fi
}

pkg_setup () {
	kill_gconf
}
pkg_preinst () {
	kill_gconf 
	# hack hack
	dodir /etc/gconf/gconf.xml.mandatory
	dodir /etc/gconf/gconf.xml.defaults
    touch ${D}/etc/gconf/gconf.xml.mandatory/.keep
	touch ${D}/etc/gconf/gconf.xml.defaults/.keep

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/gconf"' >${D}/etc/env.d/50gconf

	dodir /root/.gconfd

}
pkg_postinst () {
	kill_gconf
	gnome2_pkg_postinst

	#change the permissions to avoid some gconf bugs
	einfo "changing permissions for gconf dirs"
	find  /etc/gconf/ -type d -exec chmod ugo+rx "{}" \;
	einfo "changing permissions for gconf files"
	find  /etc/gconf/ -type f -exec chmod ugo+r "{}" \;
	
}

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"
