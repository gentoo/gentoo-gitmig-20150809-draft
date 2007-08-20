# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_Table/PEAR-DB_Table-1.5.0.ebuild,v 1.1 2007/08/20 21:38:56 jokey Exp $

inherit php-pear-r1

DESCRIPTION="Builds on PEAR DB to abstract datatypes and automate table creation, data validation"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"
DEPEND=">=dev-php/PEAR-PEAR-1.5.0"
RDEPEND="!minimal? ( >=dev-php/PEAR-MDB2-2.4.1
		    >=dev-php/PEAR-DB-1.7.11
		    dev-php/PEAR-HTML_QuickForm )"
