# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-2.2.1.ebuild,v 1.1 2003/06/03 11:13:31 foser Exp $

IUSE="doc"

PN=GConf
P=${PN}-${PV}

inherit gnome2

DESCRIPTION="Gnome Configuration System and Daemon"
HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2"

SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/ORBit2-2.4
	>=dev-libs/libxml2-2.4.17
	>=net-libs/linc-0.5
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

MAKEOPTS="${MAKEOPTS} -j1"

src_install() {

	gnome2_src_install 
    
	# hack hack
	dodir /etc/gconf/gconf.xml.mandatory
	dodir /etc/gconf/gconf.xml.defaults
	touch ${D}/etc/gconf/gconf.xml.mandatory/.keep${SLOT}
	touch ${D}/etc/gconf/gconf.xml.defaults/.keep${SLOT}

}

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
	return 0
}

pkg_setup () {
	kill_gconf
}

pkg_preinst () {
	kill_gconf 

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

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"
