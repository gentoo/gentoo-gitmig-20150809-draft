# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent-theshadow/bittorrent-theshadow-5.8.7.ebuild,v 1.6 2004/03/23 06:07:38 eradicator Exp $

inherit distutils

DESCRIPTION="TheShad0w's experimental BitTorrent client"
HOMEPAGE="http://www.bittornado.com/"
SRC_URI="http://home.elp.rr.com/tur/BitTorrent-experimental-S-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~x86"
IUSE="X"

RDEPEND="X? ( >=dev-python/wxPython-2.2 )
		>=dev-lang/python-2.1
		!virtual/bittorrent"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4.0.5"
PROVIDE="virtual/bittorrent"

S="${WORKDIR}/bittorrent-CVS-shadowsclient"

src_install() {
	distutils_src_install

	if ! use X; then
		rm ${D}/usr/bin/*gui.py
	fi

	dodir etc
	cp -a /etc/mailcap ${D}/etc/

	MAILCAP_STRING="application/x-bittorrent; /usr/bin/btdownloadgui.py '%s'; test=test -n \"\$DISPLAY\""

	if use X; then
		if [ -n "`grep 'application/x-bittorrent' ${D}/etc/mailcap`" ]; then
			# replace bittorrent entry if it already exists
			einfo "updating bittorrent mime info"
			sed -i "s,application/x-bittorrent;.*,${MAILCAP_STRING}," ${D}/etc/mailcap
		else
			# add bittorrent entry if it doesn't exist
			einfo "adding bittorrent mime info"
			echo "${MAILCAP_STRING}" >> ${D}/etc/mailcap
		fi
	else
		# get rid of any reference to the not-installed gui version
		sed -i '/btdownloadgui/d' ${D}/etc/mailcap
	fi
}

