# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-3.2.1b-r3.ebuild,v 1.1 2003/06/10 15:20:17 phosphan Exp $

inherit distutils

MY_P="${P/bittorrent/BitTorrent}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="BitTorrent is a tool for distributing files via a distributed network of nodes"
SRC_URI="http://bitconjurer.org/BitTorrent/${MY_P}.tar.gz"
HOMEPAGE="http://bitconjurer.org/BitTorrent"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

IUSE="X"

RDEPEND="X? ( >=dev-python/wxPython-2.2 )
	>=dev-lang/python-2.1"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"


mydoc="FAQ.txt README.txt LICENSE.txt"


src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/bittorrent-stats-${PV}.patch || die "patch failed"
}

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

