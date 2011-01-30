# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Policy-Dynamic-NoIndirect/Perl-Critic-Policy-Dynamic-NoIndirect-0.05.ebuild,v 1.1 2011/01/30 23:22:20 idl0r Exp $

EAPI="3"

MODULE_AUTHOR="VPIT"

inherit perl-module

DESCRIPTION="Perl::Critic policy against indirect method calls"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/indirect-0.23
	dev-perl/Perl-Critic-Dynamic
	dev-perl/Perl-Critic
	dev-lang/perl"
RDEPEND="${DEPEND}"
