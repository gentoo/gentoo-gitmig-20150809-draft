# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firebird-bin/mozilla-firebird-bin-0.6-r1.ebuild,v 1.6 2003/09/06 02:05:10 msterret Exp $

inherit nsplugins eutils

IUSE="gnome"

MY_PN=${PN/-bin/}
S=${WORKDIR}/MozillaFirebird
DESCRIPTION="The Mozilla Firebird Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/firebird/releases/${PV}/MozillaFirebird-${PV}-i686-pc-linux-gnu.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firebird"
RESTRICT="nostrip"

KEYWORDS="~x86 -ppc -sparc -alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND=">=sys-libs/lib-compat-1.0-r2
	=x11-libs/gtk+-1.2*
	virtual/x11
	!net-www/mozilla-firebird
	!net-www/mozilla-firebird-cvs"

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
	dodir /${PLUGIN_DIR}

	dodir /opt

	mv ${S} ${D}/opt/MozillaFirebird

	# Plugin path setup (rescuing the existent plugins)
	src_mv_plugins /opt/MozillaFirebird/plugins

	# Fixing permissions
	chown -R root.root ${D}/opt/MozillaFirebird

	# Truetype fonts
	cd ${D}/opt/MozillaFirebird/defaults/pref
	einfo "Enabling truetype fonts. Filesdir is ${FILESDIR}"
	epatch ${FILESDIR}/firebird-0.6-antialiasing-patch

	# Misc stuff
	dobin ${FILESDIR}/MozillaFirebird

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/mozilla-icon.png

		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/icon/mozillafirebird.desktop
	fi

}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /opt/MozillaFirebird/plugins
}

pkg_postinst() {
	einfo "This binary of Mozilla Firebird was compiled with GCC 2.96."
	einfo "It will not work with the GCC 3.x compiled version of any JDK;"
	einfo "to use java with this binary, please use blackdown-jdk 1.3.1."
}
