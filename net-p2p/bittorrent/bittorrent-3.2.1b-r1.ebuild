# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-3.2.1b-r1.ebuild,v 1.1 2003/05/07 05:46:14 phosphan Exp $

inherit distutils

MY_P="${P/bittorrent/BitTorrent}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="BitTorrent is a tool for distributing files via a distributed network of nodes"
SRC_URI="http://bitconjurer.org/BitTorrent/${MY_P}.tar.gz"
HOMEPAGE="http://bitconjurer.org/BitTorrent"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=dev-python/wxPython-2.2
	>=dev-lang/python-2.1"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"


mydoc="FAQ.txt README.txt LICENSE.txt"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch
}

pkg_postinst() {
	MAILCAP_STRING="application/x-bittorrent; /usr/bin/btdownloadgui.py '%s'; test=test -n \"\$DISPLAY\""

    if [ -n "`grep 'application/x-bittorrent' /etc/mailcap`" ]; then
    	# replace bittorrent entry if it already exists
		einfo "updating bittorrent mime info"
        sed -i "s,application/x-bittorrent;.*,${MAILCAP_STRING}," /etc/mailcap
    else
    	# add bittorrent entry if it doesn't exist
        einfo "adding bittorrent mime info"
		echo "${MAILCAP_STRING}" >> /etc/mailcap
	fi
}

