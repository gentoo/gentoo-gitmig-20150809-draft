# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firebird-bin/mozilla-firebird-bin-0.6.ebuild,v 1.1 2003/06/03 15:15:48 brad Exp $

inherit nsplugins eutils

IUSE=""

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
	!net-www/phoenix-cvs
	!new-www/phoenix-bin
	!new-www/mozilla-firebird"

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
	dodir /${PLUGIN_DIR}

	dodir /opt

	mv ${S} ${D}/opt/${MY_PN}

	# Plugin path setup (rescuing the existent plugins)
	src_mv_plugins /opt/${MY_PN}/plugins

	# Fixing permissions
	chown -R root.root ${D}/opt/${MY_PN}

	# Truetype fonts
	cd ${D}/opt/${MY_PN}/defaults/pref
	einfo "Enabling truetype fonts. Filesdir is ${FILESDIR}"
	epatch ${FILESDIR}/firebird-0.6-antialiasing-patch

	# Misc stuff
	dobin ${FILESDIR}/MozillaFirebird
}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /opt/${MY_PN}/plugins
}

pkg_postinst() {
	einfo "This binary of Mozilla Firebird was compiled with GCC 2.96."
	einfo "It will not work with the GCC 3.x compiled version of any JDK;"
	einfo "to use java with this binary, please use blackdown-jdk 1.3.1."
}
