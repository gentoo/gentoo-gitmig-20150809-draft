# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-HTMLDoc/HTML-HTMLDoc-0.10.ebuild,v 1.10 2010/04/17 16:57:25 armin76 Exp $

EAPI=2

MODULE_AUTHOR=MFRANKL
inherit perl-module

DESCRIPTION="Perl interface to the htmldoc program for producing PDF-Files from HTML-Content"

SLOT="0"
KEYWORDS="amd64 ~arm ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="app-text/htmldoc"
DEPEND="${RDEPEND}"

SRC_TEST="do"
