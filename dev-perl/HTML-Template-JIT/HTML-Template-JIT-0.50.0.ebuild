# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template-JIT/HTML-Template-JIT-0.50.0.ebuild,v 1.2 2011/09/03 21:04:48 tove Exp $

EAPI=4

MODULE_AUTHOR=SAMTREGAR
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="a just-in-time compiler for HTML::Template"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND=">=dev-perl/HTML-Template-2.8
	dev-perl/Inline"
DEPEND="${RDEPEND}"
