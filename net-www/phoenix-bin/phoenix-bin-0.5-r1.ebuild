# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/phoenix-bin/phoenix-bin-0.5-r1.ebuild,v 1.1 2003/05/10 06:57:17 george Exp $

IUSE=""

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="The Phoenix Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/${MY_PN}/releases/${PV}/${MY_PN}-${PV}-i686-pc-linux-gnu.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/phoenix/"
RESTRICT="nostrip"

KEYWORDS="~x86 -ppc -sparc  -alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND=">=sys-libs/lib-compat-1.0-r2
	( gtk2? >=x11-libs/gtk+-2.0.8 :
			=x11-libs/gtk+-1.2* )
	 virtual/x11
	 !net-www/phoenix-cvs"

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
	dodir /${PLUGIN_DIR}

	dodir /opt

	mv ${S} ${D}/opt

	# Plugin path setup (rescuing the existent plugins)
	src_mv_plugins /opt/${MY_PN}/plugins

	# Fixing permissions
	chown -R root.root ${D}/opt/${MY_PN}

	# Truetype fonts
	cd ${D}/opt/${MY_PN}/defaults/pref
	einfo "Enabling truetype fonts"
	patch < ${FILESDIR}/phoenix-0.4-antialiasing-patch

	# Misc stuff
	cp ${FILESDIR}/phoenix-opt ${WORKDIR}/phoenix
	dobin ${WORKDIR}/phoenix
	dosym /opt/libstdc++-libc6.1-1.so.2 /opt/${MY_PN}/libstdc++-libc6.2-2.so.3
}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /opt/${MY_PN}/plugins
}
