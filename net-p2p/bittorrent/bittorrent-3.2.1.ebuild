# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-3.2.1.ebuild,v 1.1 2003/03/31 20:09:19 liquidx Exp $

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

DEPEND=">=dev-python/wxPython-2.2
	>=dev-lang/python-2.1"


mydoc="FAQ.txt README.txt LICENSE.txt"

pkg_postinst() {
	# add entry to mailcap if it doesn't already exist
	if ! grep "application/x-bittorrent" /etc/mailcap;
	then
		einfo "adding application/x-bittorrent to /etc/mailcap..."
		echo 'application/x-bittorrent; /usr/bin/btdownloadprefetched.py %s; test=test -n "$DISPLAY"' >> /etc/mailcap
	fi
}

