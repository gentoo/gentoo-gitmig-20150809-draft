# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/offlineimap/offlineimap-3.99.17.ebuild,v 1.3 2003/09/08 07:38:57 msterret Exp $

inherit distutils

DESCRIPTION="Powerful IMAP/Maildir synchronization and reader support"
SRC_URI="http://gopher.quux.org:70/devel/offlineimap/offlineimap_${PV}.tar.gz"
HOMEPAGE="http://gopher.quux.org:70/devel/offlineimap"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"
SLOT="0"

DEPEND=""

src_install() {
	distutils_src_install
	dodoc offlineimap.conf offlineimap.conf.minimal offlineimap.sgml
	doman offlineimap.1
}

pkg_postinst() {
	einfo ""
	einfo "You will need to configure offlineimap by creating ~/.offlineimap.rc"
	einfo "Sample configurations are in /usr/share/doc/${P}/"
	einfo ""
}
