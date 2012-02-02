# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.100.300.ebuild,v 1.5 2012/02/02 20:22:14 ranger Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.1003
inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-3.27"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
