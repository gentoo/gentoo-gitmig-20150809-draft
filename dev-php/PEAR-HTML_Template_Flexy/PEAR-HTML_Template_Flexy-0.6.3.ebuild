# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Flexy/PEAR-HTML_Template_Flexy-0.6.3.ebuild,v 1.6 2004/08/03 17:04:38 agriffis Exp $

inherit php-pear

IUSE="javascript"
DESCRIPTION="An extremely powerful Tokenizer driven Template engine"
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc ia64"
DEPEND="javascript? ( >=dev-php/PEAR-HTML_Javascript-1.1.0 )"
