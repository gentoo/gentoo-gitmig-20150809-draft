# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_dav_svn/mod_dav_svn-9999.ebuild,v 1.1 2005/02/27 11:17:40 pauldv Exp $

DESCRIPTION="<OBSOLETE, is and will for now stay provided by subversion itself>"
SRC_URI=""
HOMEPAGE="http://subversion.tigris.org/"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~x86 ~amd64 -*"
IUSE=""

pkg_setup() {
	die "The apache module for subverion is provided by subversion itself"
}
