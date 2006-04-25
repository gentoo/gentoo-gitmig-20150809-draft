# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-bin/mozilla-bin-1.7.13.ebuild,v 1.3 2006/04/25 15:01:42 wolf31o2 Exp $

inherit eutils mozilla-launcher multilib

IUSE=""

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${PV}/mozilla-i686-pc-linux-gnu-${PV}.tar.gz"
RESTRICT="nostrip"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/libc"
RDEPEND="
	x86? (
		>=sys-libs/lib-compat-1.0-r2
		=x11-libs/gtk+-1.2*
		|| ( (	x11-libs/libXp
			x11-libs/libXt )
		virtual/x11 )
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	>=www-client/mozilla-launcher-1.41"

S=${WORKDIR}/mozilla

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/mozilla

	# Install mozilla in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	# Install /usr/bin/mozilla-bin
	install_mozilla_launcher_stub mozilla-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/mozilla-bin-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/mozilla-bin.desktop
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/mozilla

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${ROOT}${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
