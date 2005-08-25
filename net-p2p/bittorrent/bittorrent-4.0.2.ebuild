# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-4.0.2.ebuild,v 1.4 2005/08/25 09:06:45 sekretarz Exp $

inherit distutils

MY_P="${P/bittorrent/BitTorrent}"
#MY_P="${MY_P/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="tool for distributing files via a distributed network of nodes"
HOMEPAGE="http://www.bittorrent.com/"
SRC_URI="http://www.bittorrent.com/dl/${MY_P}.tar.gz"

LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~sparc ~alpha"
IUSE="X"

RDEPEND="X? (
		>=x11-libs/gtk+-2.4
		>=dev-python/pygtk-2.4
	)
	>=dev-lang/python-2.3
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	app-arch/gzip
	>=sys-apps/sed-4.0.5
	dev-python/dnspython"
PROVIDE="virtual/bittorrent"

DOCS="credits.txt"
PYTHON_MODNAME="BitTorrent"

src_install() {
	distutils_src_install
	if ! use X; then
		rm ${D}/usr/bin/*gui.py
	fi
	dohtml redirdonate.html
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

	insinto /usr/share/bittorrent
	doins ${FILESDIR}/favicon.ico

	insinto /etc/conf.d
	newins ${FILESDIR}/bttrack.conf bttrack

	exeinto /etc/init.d
	newexe ${FILESDIR}/bttrack.rc bttrack
}

pkg_postinst() {
	einfo "BitTorrent has changed to the BitTorrent Open Source License"
	einfo ">> http://www.bittorrent.com/license/"
	distutils_pkg_postinst
}
