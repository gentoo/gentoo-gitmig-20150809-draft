# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent-stats/bittorrent-stats-3.2.1b-r4.ebuild,v 1.8 2006/02/22 10:58:09 lucass Exp $

inherit distutils eutils

MY_P="${P/bittorrent-stats/BitTorrent}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="BitTorrent is a tool for distributing files via a distributed network of nodes"
SRC_URI="http://bitconjurer.org/BitTorrent/${MY_P}.tar.gz
	mirror://gentoo/${P}.patch"
HOMEPAGE="http://bitconjurer.org/BitTorrent"
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ppc alpha ~sparc"

IUSE="X"

RDEPEND="X? ( >=dev-python/wxpython-2.2 )
	>=dev-lang/python-2.1
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"
PROVIDE="virtual/bittorrent"


mydoc="FAQ.txt README.txt LICENSE.txt"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${P}.patch || die "patch failed"
}

src_install() {
	distutils_src_install
	if ! use X; then
		rm ${D}/usr/bin/*gui.py
	fi
	dodir etc
	cp -pPR /etc/mailcap ${D}/etc/

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

