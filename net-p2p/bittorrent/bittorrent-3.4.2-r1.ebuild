# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-3.4.2-r1.ebuild,v 1.4 2004/11/23 18:43:53 squinky86 Exp $

inherit distutils

MY_P="${P/bittorrent/BitTorrent}"
MY_P="${MY_P/\.0/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="tool for distributing files via a distributed network of nodes"
HOMEPAGE="http://bitconjurer.org/BitTorrent"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~arm ~amd64"
IUSE="X"

RDEPEND="X? ( <dev-python/wxpython-2.5* )
	>=dev-lang/python-2.1
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	app-arch/unzip
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

	insinto /usr/share/bittorrent
	doins ${FILESDIR}/favicon.ico

	insinto /etc/conf.d
	newins ${FILESDIR}/bttrack.conf bttrack

	exeinto /etc/init.d
	newexe ${FILESDIR}/bttrack.rc bttrack
}

pkg_postinst() {
	einfo "unofficial feature additions. If you would like statistics, please"
	einfo "install net-p2p/bittorrent-stats."
}
