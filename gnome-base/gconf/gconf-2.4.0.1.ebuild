# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-2.4.0.1.ebuild,v 1.17 2004/11/08 14:35:35 vapier Exp $

inherit gnome2

MY_PN=GConf
MY_P=${MY_PN}-${PV}
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="Gnome Configuration System and Daemon"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips arm"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/orbit-2.8
	>=dev-libs/libxml2-2.4.17
	dev-libs/popt
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( dev-util/gtk-doc
		=app-text/docbook-sgml-dtd-3.0* )"

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
	echo 'CONFIG_PROTECT_MASK="/etc/gconf"' > ${D}/etc/env.d/50gconf

	dodir /root/.gconfd

}

pkg_postinst () {

	kill_gconf

	#change the permissions to avoid some gconf bugs
	einfo "changing permissions for gconf dirs"
	find  /etc/gconf/ -type d -exec chmod ugo+rx "{}" \;
	einfo "changing permissions for gconf files"
	find  /etc/gconf/ -type f -exec chmod ugo+r "{}" \;

}

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"
