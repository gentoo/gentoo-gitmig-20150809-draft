# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mac-Pasteboard/Mac-Pasteboard-0.3.0.ebuild,v 1.1 2011/12/19 14:32:26 tove Exp $

EAPI=4

MODULE_AUTHOR=WYANT
MODULE_VERSION=0.003
inherit perl-module

DESCRIPTION="Manipulate Mac OS X clipboards/pasteboards"

SLOT="0"
KEYWORDS="" # "~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="
	virtual/perl-Module-Build
"
