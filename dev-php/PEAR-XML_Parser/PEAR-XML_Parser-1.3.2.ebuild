# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Parser/PEAR-XML_Parser-1.3.2.ebuild,v 1.2 2009/11/24 14:41:15 beandog Exp $

inherit php-pear-r1

DESCRIPTION="XML parsing class based on PHP's SAX parser"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND="|| ( <dev-php/PEAR-PEAR-1.71
	dev-php/PEAR-Console_Getopt )"
