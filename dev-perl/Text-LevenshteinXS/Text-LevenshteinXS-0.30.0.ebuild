# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-LevenshteinXS/Text-LevenshteinXS-0.30.0.ebuild,v 1.1 2011/08/28 13:01:59 tove Exp $

EAPI=4

MODULE_AUTHOR=JGOLDBERG
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="An XS implementation of the Levenshtein edit distance"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
