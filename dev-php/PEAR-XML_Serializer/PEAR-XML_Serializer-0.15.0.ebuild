# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Serializer/PEAR-XML_Serializer-0.15.0.ebuild,v 1.6 2005/03/27 15:56:15 kloeri Exp $

inherit php-pear

DESCRIPTION="Swiss-army knive for reading and writing XML files."
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~hppa amd64 ~ppc64"
IUSE=""
RDEPEND="dev-php/PEAR-PEAR
		>=dev-php/PEAR-XML_Parser-1.2.1
		>=dev-php/PEAR-XML_Util-1.1.1"
