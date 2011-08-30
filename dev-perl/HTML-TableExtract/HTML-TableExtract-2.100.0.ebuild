# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-2.100.0.ebuild,v 1.1 2011/08/30 13:57:25 tove Exp $

EAPI=4

MODULE_AUTHOR=MSISK
MODULE_VERSION=2.10
inherit perl-module

DESCRIPTION="The Perl Table-Extract Module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/HTML-Element-Extended-1.16
	dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

mydoc="TODO"
