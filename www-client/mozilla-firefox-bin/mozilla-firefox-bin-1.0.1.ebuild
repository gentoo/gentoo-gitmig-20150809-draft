# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox-bin/mozilla-firefox-bin-1.0.1.ebuild,v 1.2 2005/03/23 20:05:19 seemant Exp $

inherit nsplugins eutils mozilla-launcher

IUSE="gnome"

DESCRIPTION="The Mozilla Firefox Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/linux-i686/en-US/firefox-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

KEYWORDS="-* x86 amd64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/libc"
RDEPEND="virtual/x11
	x86? (
		>=sys-libs/lib-compat-1.0-r2
		>=x11-libs/gtk+-2.2
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	>=www-client/mozilla-launcher-1.22"

S=${WORKDIR}/firefox

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
		# Fix bug 54179: Install .desktop file into /usr/share/applications
		# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
		insinto /usr/share/applications
		doins ${FILESDIR}/icon/mozillafirefox-bin.desktop
	fi

	# Normally firefox-bin-0.9 must be run as root once before it can
	# be run as a normal user.  Drop in some initialized files to
	# avoid this.
	einfo "Extracting firefox-bin-${PV} initialization files"
	tar xjpf ${FILESDIR}/firefox-bin-0.9-init.tar.bz2 -C ${D}/opt/firefox
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

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
