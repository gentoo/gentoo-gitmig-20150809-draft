# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Flexy/PEAR-HTML_Template_Flexy-0.9.2.ebuild,v 1.3 2004/11/29 10:57:16 blubb Exp $

inherit php-pear

IUSE="javascript"
DESCRIPTION="An extremely powerful Tokenizer driven Template engine"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ~ia64 ~amd64"
DEPEND="javascript? ( >=dev-php/PEAR-HTML_Javascript-1.1.0 )"
