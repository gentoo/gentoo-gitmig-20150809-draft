# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firefox-bin/mozilla-firefox-bin-0.9-r1.ebuild,v 1.2 2004/06/16 22:32:11 agriffis Exp $

inherit nsplugins eutils mozilla-launcher

IUSE="gnome"

MY_PN=${PN/-bin/}
S=${WORKDIR}/firefox
DESCRIPTION="The Mozilla Firefox Web Browser"
# Mirrors have it in one of the following places, depending on what
# mirror you check and when you check it... :-(
SRC_URI="
	http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/firefox-${PV}-i686-linux-gtk2+xft.tar.gz
	http://ftp.mozilla.org/pub/firefox/releases/${PV}/firefox-${PV}-i686-linux-gtk2+xft.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

KEYWORDS="-* ~x86 ~amd64"
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
	>=net-www/mozilla-launcher-1.13"

src_install() {
	# Install firefox in /opt
	dodir /opt
	mv ${S} ${D}/opt/firefox

	# Plugin path setup (rescuing the existing plugins)
	src_mv_plugins /opt/firefox/plugins

	# Fixing permissions
	chown -R root:root ${D}/opt/firefox

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
	export MOZILLA_FIVE_HOME=${ROOT}/opt/firefox

	# Remove the old plugins dir
	pkg_mv_plugins /opt/firefox/plugins

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME=${ROOT}/opt/firefox

	# Normally firefox-bin-0.9 must be run as root once before it can
	# be run as a normal user.  Drop in some initialized files to
	# avoid this.
	einfo "Extracting firefox-bin-${PV} initialization files"
	cd ${MOZILLA_FIVE_HOME} && tar xjpf ${FILESDIR}/firefox-bin-${PV}-init.tar.bz2

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
