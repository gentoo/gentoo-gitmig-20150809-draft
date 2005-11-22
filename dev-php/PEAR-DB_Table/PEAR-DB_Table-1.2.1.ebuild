# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_Table/PEAR-DB_Table-1.2.1.ebuild,v 1.5 2005/11/22 13:51:15 corsair Exp $

inherit php-pear-r1

DESCRIPTION="Builds on PEAR DB to abstract datatypes and automate table creation, data validation"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Date
	dev-php/PEAR-DB
	dev-php/PEAR-HTML_QuickForm"
