# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PHP_Debug/PEAR-PHP_Debug-1.0.3.ebuild,v 1.1 2009/08/22 19:11:36 beandog Exp $

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
