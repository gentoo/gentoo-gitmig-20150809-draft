# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Script/Test-Script-1.03.ebuild,v 1.8 2009/07/02 18:41:59 jer Exp $

MODULE_AUTHOR=ADAMK

inherit perl-module

DESCRIPTION="Cross-platform basic tests for scripts"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-File-Spec
	dev-perl/IPC-Run3
	virtual/perl-Test-Simple"

SRC_TEST=do
