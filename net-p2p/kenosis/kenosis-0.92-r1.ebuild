# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kenosis/kenosis-0.92-r1.ebuild,v 1.1 2005/01/12 23:13:20 pythonhead Exp $

inherit distutils

DESCRIPTION="Fully-distributed p2p RPC system with modified bittorrent client"
HOMEPAGE="http://sourceforge.net/projects/kenosis"
SRC_URI="mirror://sourceforge/kenosis/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"

IUSE="X"
DEPEND="X? ( <dev-python/wxpython-2.5* )
	>=dev-lang/python-2.1
	!virtual/bittorrent"
PROVIDE="virtual/bittorrent"

src_compile() {
	mv kenosis_setup.py setup.py
	distutils_src_compile
	cd ${S}/bt
	python setup.py build
}

src_install() {
	cd ${S}
	distutils_src_install
	cd ${S}/bt
	python setup.py install --root=${D}

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
