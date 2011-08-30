# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Policy-Dynamic-NoIndirect/Perl-Critic-Policy-Dynamic-NoIndirect-0.60.0.ebuild,v 1.1 2011/08/30 18:26:10 tove Exp $

EAPI=4

MODULE_AUTHOR=VPIT
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Perl::Critic policy against indirect method calls"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/indirect-0.250.0
	dev-perl/Perl-Critic-Dynamic
	dev-perl/Perl-Critic"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
