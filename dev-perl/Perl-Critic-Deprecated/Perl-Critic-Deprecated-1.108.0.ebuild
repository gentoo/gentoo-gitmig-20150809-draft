# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Deprecated/Perl-Critic-Deprecated-1.108.0.ebuild,v 1.1 2011/08/29 10:49:38 tove Exp $

EAPI=4

MODULE_AUTHOR=ELLIOTJS
MODULE_VERSION=1.108
inherit perl-module

DESCRIPTION="Policies that were formally included with Perl::Critic itself, but which have been superseded by others"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Readonly
	dev-perl/Perl-Critic"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
