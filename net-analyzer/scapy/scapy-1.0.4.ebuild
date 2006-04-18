# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scapy/scapy-1.0.4.ebuild,v 1.1 2006/04/18 10:50:12 lcars Exp $

inherit python multilib

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/"
SRC_URI="http://www.secdev.org/projects/scapy/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnuplot pyx crypt graphviz imagemagick visual"

DEPEND="virtual/python
	net-analyzer/tcpdump
	gnuplot? ( dev-python/gnuplot-py )
	pyx? ( dev-python/pyx )
	crypt? ( dev-python/pycrypto )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( media-gfx/imagemagick )
	visual? ( dev-python/visual )"

src_install() {
	exeinto /usr/bin
	newexe scapy.py scapy

	# also install scapy as a importable python module
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins scapy.py

	insinto /etc
	doins ${FILESDIR}/ethertypes
	dodoc AUTHORS COPYING README changelog.txt
	doman scapy.1.*
	}

pkg_postinst() {
	python_mod_optimize

	einfo ""
	einfo "- Check http://www.secdev.org/projects/scapy/ for additional info"
	einfo ""
	einfo "- To subscribe to the mailing-list, send a mail to scapy.ml-subscribe(at)secdev.org"
	einfo "- To send a mail to the mailing-list: scapy.ml(at)secdev.org"
	einfo "- Web archive : http://news.gmane.org/gmane.comp.security.scapy.general"
	einfo "- NNTP, RSS, etc : http://gmane.org/info.php?group=gmane.comp.security.scapy.general"
	einfo ""
}

pkg_postrm() {
	python_mod_cleanup
}
