# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Template_Flexy/PEAR-HTML_Template_Flexy-1.2.1-r1.ebuild,v 1.2 2005/09/09 14:21:30 sebastian Exp $

inherit php-pear-r1

IUSE="javascript"
DESCRIPTION="An extremely powerful Tokenizer driven Template engine"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
DEPEND="javascript? ( >=dev-php/PEAR-HTML_Javascript-1.1.0 )"
