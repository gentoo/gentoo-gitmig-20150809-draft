# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird-bin/mozilla-sunbird-bin-0.2.20041112.ebuild,v 1.5 2005/03/23 20:03:48 seemant Exp $

inherit mozilla-launcher

MY_PV=${PV##*.} ; MY_PV=${MY_PV:0:4}-${MY_PV:4:2}-${MY_PV:6:2}
DESCRIPTION="The Mozilla Sunbird Calendar"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/calendar/sunbird/nightly/${MY_PV}/sunbird-i686-linux-gtk2+xft.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
# can't mirror because the name isn't unique
RESTRICT="nostrip nomirror"

KEYWORDS="-* ~x86 ~amd64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""
S=${WORKDIR}/sunbird

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
	virtual/x11
	>=www-client/mozilla-launcher-1.18"

src_install() {
	# Install sunbird in /opt
	dodir /opt
	mv ${S} ${D}/opt/sunbird

	# Fixing permissions
	chown -R root:root ${D}/opt/sunbird

	# mozilla-launcher-1.8 supports -bin versions
	dodir /usr/bin
	dosym /usr/libexec/mozilla-launcher /usr/bin/sunbird-bin

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozillasunbird-bin-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillasunbird-bin.desktop
}

pkg_preinst() {
	export MOZILLA_FIVE_HOME=${ROOT}/opt/sunbird

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME=${ROOT}/opt/sunbird

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
