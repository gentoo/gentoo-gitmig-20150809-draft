# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_Table/PEAR-DB_Table-1.2.1.ebuild,v 1.4 2005/11/21 15:44:07 josejx Exp $

inherit php-pear-r1

DESCRIPTION="Builds on PEAR DB to abstract datatypes and automate table creation, data validation"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Date
	dev-php/PEAR-DB
	dev-php/PEAR-HTML_QuickForm"
