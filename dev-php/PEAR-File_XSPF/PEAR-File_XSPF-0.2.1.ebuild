# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_XSPF/PEAR-File_XSPF-0.2.1.ebuild,v 1.4 2008/11/09 11:52:01 vapier Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Package for Manipulating XSPF Playlists"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Validate-0.6.2
	>=dev-php/PEAR-XML_Parser-1.2.7
	>=dev-php/PEAR-XML_Tree-1.1.0"
