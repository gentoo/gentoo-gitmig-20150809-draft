# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-REPL/Devel-REPL-1.003006.ebuild,v 1.1 2009/06/23 07:39:18 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="OLIVER"

inherit perl-module

DESCRIPTION="a modern perl interactive shell"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/MooseX-Object-Pluggable-0.0011
	dev-perl/File-HomeDir
	dev-perl/namespace-clean
	>=dev-perl/MooseX-Getopt-0.18
	>=dev-perl/MooseX-AttributeHelpers-0.18.01
	dev-perl/Task-Weaken
	dev-perl/Moose"
RDEPEND="${DEPEND}"
