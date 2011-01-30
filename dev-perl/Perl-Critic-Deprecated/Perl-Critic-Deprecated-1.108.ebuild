# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Deprecated/Perl-Critic-Deprecated-1.108.ebuild,v 1.1 2011/01/30 23:41:24 idl0r Exp $

EAPI="3"

MODULE_AUTHOR="ELLIOTJS"

inherit perl-module

DESCRIPTION="Policies that were formally included with Perl::Critic itself, but which have been superseded by others"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Readonly
	dev-perl/Perl-Critic
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
