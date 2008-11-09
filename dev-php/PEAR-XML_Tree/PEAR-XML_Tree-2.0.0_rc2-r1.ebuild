# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Tree/PEAR-XML_Tree-2.0.0_rc2-r1.ebuild,v 1.18 2008/11/09 11:51:09 vapier Exp $

inherit php-pear-r1

DESCRIPTION="build XML data structures using a tree representation, without the need for an extension like DOMXML"

LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-XML_Parser-1.2.7"
