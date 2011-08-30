# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Next/File-Next-1.60.0.ebuild,v 1.1 2011/08/30 15:47:22 tove Exp $

EAPI=4

MODULE_AUTHOR=PETDANCE
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="File::Next is an iterator-based module for finding files"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Test-Simple"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
