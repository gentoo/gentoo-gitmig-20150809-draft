# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_W3C_CSSValidator/PEAR-Services_W3C_CSSValidator-0.2.2.ebuild,v 1.1 2011/04/23 15:13:23 olemarkus Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides an object oriented interface to the API of the
W3 CSS Validator application (http://jigsaw.w3.org/css-validator/)."

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-HTTP_Request-1.3.0"

need_php5
