# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Script/Test-Script-1.03.ebuild,v 1.2 2008/04/29 15:38:17 fmccor Exp $

MODULE_AUTHOR=ADAMK

inherit perl-module

DESCRIPTION="Cross-platform basic tests for scripts"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-File-Spec
	dev-perl/IPC-Run3
	virtual/perl-Test-Simple"

SRC_TEST=do
