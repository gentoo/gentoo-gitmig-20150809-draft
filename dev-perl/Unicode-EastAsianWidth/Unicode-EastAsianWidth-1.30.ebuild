# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-EastAsianWidth/Unicode-EastAsianWidth-1.30.ebuild,v 1.6 2012/05/06 18:08:30 armin76 Exp $

EAPI=4

MODULE_AUTHOR="AUDREYT"
inherit perl-module

DESCRIPTION="East Asian Width properties"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	dev-perl/Module-Install
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Module-Build"

SRC_TEST="do"
