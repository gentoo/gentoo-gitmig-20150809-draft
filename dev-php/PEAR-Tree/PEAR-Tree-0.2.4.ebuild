# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Tree/PEAR-Tree-0.2.4.ebuild,v 1.1 2005/02/16 07:22:13 sebastian Exp $

inherit php-pear

DESCRIPTION="Generic tree management, currently supports DB and XML as data
sources."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-DB-1.3
		>=dev-php/PEAR-XML_Parser-1.0"
