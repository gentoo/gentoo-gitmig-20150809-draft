# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Clean/HTML-Clean-0.8-r1.ebuild,v 1.20 2009/03/12 17:28:42 tove Exp $

EAPI=2

MODULE_AUTHOR=LINDNER
inherit perl-module

DESCRIPTION="Cleans up HTML code for web browsers, not humans"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="!<app-text/html-xml-utils-5.3"
