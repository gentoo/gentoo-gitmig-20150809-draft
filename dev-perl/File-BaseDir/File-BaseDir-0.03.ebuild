# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BaseDir/File-BaseDir-0.03.ebuild,v 1.11 2011/03/27 15:44:59 klausman Exp $

EAPI=3

MODULE_AUTHOR=PARDUS
inherit perl-module

DESCRIPTION="Use the Freedesktop.org base directory specification"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
