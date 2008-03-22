# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_QuickForm_ElementGrid/PEAR-HTML_QuickForm_ElementGrid-0.1.1.ebuild,v 1.3 2008/03/22 20:13:30 hollow Exp $

inherit php-pear-r1

DESCRIPTION="An HTML_QuickForm meta-element which holds any other element in a grid"

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-HTML_QuickForm-3.2.5
	>=dev-php/PEAR-HTML_Table-1.7.5"
