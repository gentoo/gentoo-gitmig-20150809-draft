# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-BaseDir/File-BaseDir-0.03.ebuild,v 1.8 2010/10/23 08:22:14 ssuominen Exp $

EAPI=3

MODULE_AUTHOR=PARDUS
inherit perl-module

DESCRIPTION="Use the Freedesktop.org base directory specification"

SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
