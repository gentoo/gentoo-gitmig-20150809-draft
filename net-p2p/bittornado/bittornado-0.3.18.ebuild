# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittornado/bittornado-0.3.18.ebuild,v 1.11 2007/07/02 20:35:32 armin76 Exp $

inherit distutils eutils

MY_PN="BitTornado"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TheShad0w's experimental BitTorrent client"
HOMEPAGE="http://www.bittornado.com/"
SRC_URI="http://download2.bittornado.com/download/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="gtk"

RDEPEND="gtk? ( >=dev-python/wxpython-2.4 )
	>=dev-lang/python-2.1
	!virtual/bittorrent"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/sed-4.0.5"
PROVIDE="virtual/bittorrent"

S="${WORKDIR}/${MY_PN}-CVS"
PIXMAPLOC="/usr/share/pixmaps/bittornado"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fixes wrong icons path
	sed -i "s:os.path.abspath(os.path.dirname(os.path.realpath(sys.argv\[0\]))):\"${PIXMAPLOC}/\":" btdownloadgui.py
	# fixes a bug with < wxpython-2.5 which is not yet available in portage
	epatch ${FILESDIR}/${PN}-wxpython-pre2.5-fix.patch
}

src_install() {
	distutils_src_install

	if use gtk; then
		dodir ${PIXMAPLOC}
		insinto ${PIXMAPLOC}
		doins icons/*.ico icons/*.gif
	else
		# get rid of any reference to the not-installed gui version
		rm ${D}/usr/bin/*gui.py
	fi

	newicon ${FILESDIR}/favicon.ico ${PN}.ico
	domenu ${FILESDIR}/bittornado.desktop

	newconfd ${FILESDIR}/bttrack.conf bttrack
	newinitd ${FILESDIR}/bttrack.rc bttrack
}
