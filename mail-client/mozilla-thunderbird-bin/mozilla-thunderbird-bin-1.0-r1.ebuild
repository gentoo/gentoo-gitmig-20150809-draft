# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird-bin/mozilla-thunderbird-bin-1.0-r1.ebuild,v 1.2 2005/03/23 20:04:33 seemant Exp $

inherit nsplugins eutils mozilla-launcher

MY_PN=${PN/-bin/}
S=${WORKDIR}/thunderbird

DESCRIPTION="The Mozilla Thunderbird Mail & News Reader"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/1.0/linux-i686-gtk2+xft/en-US/thunderbird-${PV}.tar.gz"

HOMEPAGE="http://www.mozilla.org/projects/thunderbird"
RESTRICT="nostrip"

KEYWORDS="-* ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="virtual/x11
	>=dev-libs/libIDL-0.8.0
	>=x11-libs/gtk+-2.1.1
	virtual/xft
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	>=www-client/mozilla-launcher-1.28"

src_install() {
	# Install thunderbird in /opt
	dodir /opt
	mv ${S} ${D}/opt/thunderbird

	# Fixing permissions
	chown -R root:root ${D}/opt/thunderbird

	# Create stub to call mozilla-launcher
	dodir /usr/bin
	cat <<EOF >${D}/usr/bin/thunderbird-bin
#!/bin/sh
# 
# Stub script to run mozilla-launcher.  We used to use a symlink here but
# OOo brokenness makes it necessary to use a stub instead:
# http://bugs.gentoo.org/show_bug.cgi?id=78890

export MOZILLA_LAUNCHER=thunderbird-bin
exec /usr/libexec/mozilla-launcher "\$@"
EOF
chmod 0755 ${D}/usr/bin/thunderbird-bin

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozillathunderbird-bin-icon.png
	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillathunderbird-bin.desktop

	# Normally thunderbird-bin-0.7 must be run as root once before it
	# can be run as a normal user.  Drop in some initialized files to
	# avoid this.
	einfo "Extracting firefox-bin-${PV} initialization files"
	tar xjpf ${FILESDIR}/thunderbird-bin-0.7-init.tar.bz2 \
		-C ${D}/opt/thunderbird
}

pkg_preinst() {
	# Remove entire installed instance to solve various
	# problems, for example see bug 27719
	rm -rf ${ROOT}/opt/MozillaThunderbird
	rm -rf ${ROOT}/opt/thunderbird
}

pkg_postinst() {
	einfo "To enable Enigmail, you must install the Enigmail and Enigmime"
	einfo "extensions as root.  Go to Tools / Options / Extensions and click"
	einfo "on Install Extension to install Enigmail in your Thunderbird build."
	einfo "Restart Thunderbird after having installed both extensions."
	einfo ""
	einfo "The extensions are located at http://enigmail.mozdev.org/"
	einfo ""
	einfo "Please note that the binary name has changed from MozillaThunderbird"
	einfo "to simply thunderbird-bin"
	einfo ""

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
