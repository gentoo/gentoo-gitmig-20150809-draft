# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firefox-bin/mozilla-firefox-bin-0.8-r1.ebuild,v 1.2 2004/06/02 07:44:56 lv Exp $

inherit nsplugins eutils mozilla-launcher

IUSE="gnome"

MY_PN=${PN/-bin/}
S=${WORKDIR}/firefox
DESCRIPTION="The Mozilla Firefox Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/firefox-${PV}-i686-linux-gtk2+xft.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

KEYWORDS="-* ~x86 amd64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11
	x86? (
		>=sys-libs/lib-compat-1.0-r2
		>=x11-libs/gtk+-2.2
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	virtual/x11
	>=net-www/mozilla-launcher-1.9"

src_install() {
	# Install firefox in /opt
	dodir /opt
	mv ${S} ${D}/opt/firefox

	# Plugin path setup (rescuing the existing plugins)
	src_mv_plugins /opt/firefox/plugins

	# Fixing permissions
	chown -R root:root ${D}/opt/firefox

	# Truetype fonts
	cd ${D}/opt/firefox/defaults/pref
	einfo "Enabling truetype fonts. Filesdir is ${FILESDIR}"
	epatch ${FILESDIR}/firebird-0.7-antialiasing-patch

	# mozilla-launcher-1.8 supports -bin versions
	dodir /usr/bin
	dosym /usr/libexec/mozilla-launcher /usr/bin/firefox-bin

	# Install icon and .desktop for menu entry
	if use gnome; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/mozillafirefox-bin-icon.png
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/icon/mozillafirefox-bin.desktop
	fi
}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /opt/firefox/plugins
}

pkg_postinst() {
	update_mozilla_launcher_symlinks
}

pkg_postun() {
	update_mozilla_launcher_symlinks
}
