# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_DataObject_FormBuilder/PEAR-DB_DataObject_FormBuilder-1.0.0_rc7.ebuild,v 1.2 2009/04/21 19:40:26 hollow Exp $

inherit php-pear-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Class to automatically build HTML_QuickForm objects from a DB_DataObject-derived class"
LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
IUSE="minimal"

DEPEND=""
RDEPEND=">=dev-php/PEAR-DB_DataObject-1.8.5
	>=dev-php/PEAR-HTML_QuickForm-3.2.4
	!minimal? (
		>=dev-php/PEAR-Date-1.4.7
		>=dev-php/PEAR-HTML_Table-1.7.5
		>=dev-php/PEAR-HTML_QuickForm_ElementGrid-0.1.0
	)"
