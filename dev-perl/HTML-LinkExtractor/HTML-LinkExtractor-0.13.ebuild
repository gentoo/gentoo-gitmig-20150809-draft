# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-LinkExtractor/HTML-LinkExtractor-0.13.ebuild,v 1.12 2010/02/03 14:50:53 tove Exp $

EAPI=2

MODULE_AUTHOR=PODMASTER
inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."

SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/HTML-Parser"
RDEPEND="${DEPEND}
	dev-perl/URI"
