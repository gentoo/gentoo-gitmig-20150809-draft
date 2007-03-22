# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_DataObject/PEAR-DB_DataObject-1.8.5.ebuild,v 1.1 2007/03/22 18:44:46 chtekk Exp $

inherit php-pear-r1

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="An SQL Builder, Object Interface to Database Tables."
LICENSE="PHP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1
		>=dev-php/PEAR-Date-1.4.3-r1
		>=dev-php/PEAR-Validate-0.5.0-r1"
