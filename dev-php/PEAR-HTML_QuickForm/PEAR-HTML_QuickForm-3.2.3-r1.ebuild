# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm/PEAR-HTML_QuickForm-3.2.3-r1.ebuild,v 1.3 2005/09/11 16:17:35 weeve Exp $

inherit php-pear-r1

DESCRIPTION="The PEAR::HTML_QuickForm package provides methods for creating, validating, processing HTML forms."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~sparc ~x86"
DEPEND=">=dev-php/PEAR-HTML_Common-1.2.1
		dev-php/PEAR-HTML_Template_Flexy
		dev-php/PEAR-HTML_Template_IT"
# the last two would be option on doc? but I think we should put the docs there
# anyway
IUSE=""
