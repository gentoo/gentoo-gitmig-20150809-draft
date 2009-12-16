# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Getopt-Long/Getopt-Long-2.38.ebuild,v 1.8 2009/12/16 21:50:03 abcd Exp $

EAPI=2

MODULE_AUTHOR=JV
inherit perl-module

DESCRIPTION="Advanced handling of command line options"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ~ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="virtual/perl-PodParser"
DEPEND="${RDEPEND}"

SRC_TEST=do
