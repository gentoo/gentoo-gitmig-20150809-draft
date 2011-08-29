# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Policy-Dynamic-NoIndirect/Perl-Critic-Policy-Dynamic-NoIndirect-0.50.0.ebuild,v 1.1 2011/08/29 10:48:10 tove Exp $

EAPI=4

MODULE_AUTHOR=VPIT
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Perl::Critic policy against indirect method calls"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/indirect-0.23
	dev-perl/Perl-Critic-Dynamic
	dev-perl/Perl-Critic"
DEPEND="${RDEPEND}"
