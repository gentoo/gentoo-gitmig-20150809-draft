# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-HTMLDoc/HTML-HTMLDoc-0.10.ebuild,v 1.9 2010/02/03 14:44:18 tove Exp $

EAPI=2

MODULE_AUTHOR=MFRANKL
inherit perl-module

DESCRIPTION="Perl interface to the htmldoc program for producing PDF-Files from HTML-Content"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="app-text/htmldoc"
DEPEND="${RDEPEND}"

SRC_TEST="do"
