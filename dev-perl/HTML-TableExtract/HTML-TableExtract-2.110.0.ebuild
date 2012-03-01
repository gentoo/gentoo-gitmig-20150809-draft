# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-2.110.0.ebuild,v 1.4 2012/03/01 20:34:15 ranger Exp $

EAPI=4

MODULE_AUTHOR=MSISK
MODULE_VERSION=2.11
inherit perl-module

DESCRIPTION="The Perl Table-Extract Module"

SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/HTML-Element-Extended-1.16
	dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

mydoc="TODO"
