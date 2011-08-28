# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-XML/Template-XML-2.170.0.ebuild,v 1.1 2011/08/28 16:57:03 tove Exp $

EAPI=4

MODULE_AUTHOR=ABW
MODULE_VERSION=2.17
inherit perl-module

DESCRIPTION="XML plugins for the Template Toolkit"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/Template-Toolkit-2.15-r1
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-RSS
	dev-perl/XML-Simple
	dev-perl/XML-XPath"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/bug-144689-branch-2.17.patch" )
SRC_TEST="do"
