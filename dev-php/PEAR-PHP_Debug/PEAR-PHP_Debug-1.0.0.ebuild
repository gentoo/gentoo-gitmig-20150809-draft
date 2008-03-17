# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Debug/PEAR-PHP_Debug-1.0.0.ebuild,v 1.1 2008/03/17 12:49:34 jokey Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides assistance in debugging PHP code (program trace, variables display,
process time, included files, queries executed, watch variables etc. "

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( dev-php/PEAR-Text_Highlighter
		    dev-php/PEAR-Services_W3C_HTMLValidator )"

need_php5
