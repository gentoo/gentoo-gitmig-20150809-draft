# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_CSS/PEAR-HTML_CSS-1.5.1.ebuild,v 1.1 2008/03/17 12:45:06 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides a simple interface for generating a stylesheet declaration."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"
RDEPEND=">=dev-php/PEAR-HTML_Common-1.2.4
	!minimal? ( >=dev-php/PEAR-Services_W3C_CSSValidator-0.1.0
		    >=dev-php5/phpunit-3.2.0 )"
need_php5
