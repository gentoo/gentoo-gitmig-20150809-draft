# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-3.3.0.ebuild,v 1.1 2003/12/17 18:35:13 luke-jr Exp $

inherit distutils

MY_P="${P/bittorrent/BitTorrent}"
MY_P="${MY_P/\.0/}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="BitTorrent is a tool for distributing files via a distributed network of nodes"
SRC_URI="http://bitconjurer.org/BitTorrent/${MY_P}.tar.gz"
HOMEPAGE="http://bitconjurer.org/BitTorrent"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

IUSE="X"

RDEPEND="X? ( >=dev-python/wxPython-2.2 )
	>=dev-lang/python-2.1
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"
PROVIDE="virtual/bittorrent"


DOCS="credits.txt"

src_install() {
	distutils_src_install
	if ! use X; then
		rm ${D}/usr/bin/*gui.py
	fi
	dohtml redirdonate.html
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

pkg_postinst() {
	einfo "Please note that the net-p2p/bittorrent package no longer has"
	einfo "unofficial feature additions. If you would like advanced features,"
	einfo "please look into the other BitTorrent clients in Portage:"
	einfo "    net-p2p/bittorrent-stats     - Only the -stats patch"
	einfo "                                   (formerly net-p2p/bittorrent)"
	einfo "    net-p2p/bittorrent-mxs       - mxs's patched BT client"
	einfo "    net-p2p/bittorrent-theshadow - TheSHAD0W's client. Recommended."
	einfo "    net-p2p/azureus-bin          - Java BT client"
}

