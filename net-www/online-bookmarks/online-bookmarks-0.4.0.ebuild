# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/online-bookmarks/online-bookmarks-0.4.0.ebuild,v 1.2 2004/07/17 09:52:41 dholm Exp $

inherit webapp

S=${WORKDIR}/${PN}

DESCRIPTION="a Bookmark management system to store your Bookmarks, Favorites and Links right in the WWW where they actually belong"
HOMEPAGE="http://www.frech.ch/online-bookmarks/index.php"
SRC_URI="http://www.frech.ch/online-bookmarks/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

# Glimpse is actually optional, but since there is no USE flag, require it
RDEPEND="virtual/php"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# prepare ${D} for our arrival
	webapp_src_preinst

	# Install documentation and then get rid of it so it does not clog up
	# webapp-config instances (except INSTALL, which will be our postinstall
	# documentation)
	dodoc CHANGES CREDITS GPL.txt INSTALL LICENSE README UPGRADE VERSION
	rm CHANGES CREDITS GPL.txt LICENSE README UPGRADE VERSION

	# Install to webapp-config master directory
	cp -a * "${D}/${MY_HTDOCSDIR}"

	# Identify the configuration files that this app uses
	webapp_configfile "${MY_HTDOCSDIR}/config/config.php"
	webapp_configfile "${MY_HTDOCSDIR}/config/connect.php"

	# Add the post-installation instructions
	webapp_postinst_txt en INSTALL

	# Let webapp.eclass do the rest
	webapp_src_install
}
