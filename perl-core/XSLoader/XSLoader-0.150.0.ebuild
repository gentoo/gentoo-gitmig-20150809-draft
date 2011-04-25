# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/XSLoader/XSLoader-0.150.0.ebuild,v 1.3 2011/04/25 16:29:47 grobian Exp $

EAPI=4

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Dynamically load C libraries into Perl code"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
