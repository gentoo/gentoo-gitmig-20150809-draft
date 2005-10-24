# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-4.1.6-r1.ebuild,v 1.2 2005/10/24 19:56:36 mkay Exp $

inherit distutils fdo-mime eutils

MY_P="${P/bittorrent/BitTorrent}"
#MY_P="${MY_P/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="tool for distributing files via a distributed network of nodes"
HOMEPAGE="http://www.bittorrent.com/"
SRC_URI="http://www.bittorrent.com/dl/${MY_P}.tar.gz"

LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86"
IUSE="gtk"

RDEPEND="gtk? (
		>=x11-libs/gtk+-2.4
		>=dev-python/pygtk-2.4
	)
	>=dev-lang/python-2.3
	>=dev-python/pycrypto-2.0
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	app-arch/gzip
	>=sys-apps/sed-4.0.5
	dev-python/dnspython"
PROVIDE="virtual/bittorrent"

DOCS="TRACKERLESS.txt LICENSE.txt"
PYTHON_MODNAME="BitTorrent"

src_unpack() {
	unpack ${A}
	cd ${S}

	# path for documentation is in lowercase (see bug #109743)
	sed -i -r "s:(dp.*appdir):\1.lower():" BitTorrent/platform.py
}

src_install() {
	distutils_src_install
	if ! use gtk; then
		rm ${D}/usr/bin/bittorrent
	fi
	dohtml redirdonate.html
	dodir etc
	cp -pPR /etc/mailcap ${D}/etc/

    mv ${D}/usr/share/doc/${P}/{credits-l10n.txt,credits.txt} \
		${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/share/doc/${P}
	mv ${D}/usr/share/doc/${PF} ${D}/usr/share/doc/${P}
					
			
	MAILCAP_STRING="application/x-bittorrent; /usr/bin/bittorrent '%s'; test=test -n \"\$DISPLAY\""

	if use gtk; then
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

	if use gtk ; then
		cp ${D}/usr/share/pixmaps/${MY_P}/bittorrent.ico ${D}/usr/share/pixmaps/
		make_desktop_entry "bittorrent" "BitTorrent" \
			/usr/share/pixmaps/bittorrent.ico "Network" "/usr/bin/"
	fi

	insinto /etc/conf.d
	newins ${FILESDIR}/bttrack.conf bttrack

	exeinto /etc/init.d
	newexe ${FILESDIR}/bttrack.rc-4.1 bttrack
}

pkg_postinst() {
	einfo "Remember that BitTorrent has changed file naming scheme"
	einfo "To run BitTorrent just execute /usr/bin/bittorrent"
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}
