# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Moose/IO-Moose-0.1003.ebuild,v 1.3 2009/11/22 21:05:24 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="DEXTER"

inherit perl-module

DESCRIPTION="Reimplementation of IO::* with improvements"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/MooseX-GlobRef-0.07
	dev-perl/Taint-Runtime
	dev-perl/Fatal-Exception
	dev-perl/constant-boolean
	dev-perl/Exception-Died
	>=dev-perl/Test-Assert-0.0501
	>=dev-perl/Exception-System-0.11
	>=dev-perl/Exception-Base-0.22.01
	dev-perl/maybe
	dev-perl/namespace-clean
	dev-perl/Exception-Warning
	>=dev-perl/Test-Unit-Lite-0.12
	dev-perl/Class-Inspector
	>=dev-perl/File-Stat-Moose-0.06"
RDEPEND="${DEPEND}"
