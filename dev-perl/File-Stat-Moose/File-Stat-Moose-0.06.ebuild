# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Stat-Moose/File-Stat-Moose-0.06.ebuild,v 1.1 2009/06/23 07:41:09 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="DEXTER"

inherit perl-module

DESCRIPTION="Status info for a file - Moose-based"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/DateTime
	dev-perl/parent
	dev-perl/Sub-Exporter
	>=dev-perl/Exception-Warning-0.03
	>=dev-perl/Test-Unit-Lite-0.12
	>=dev-perl/Fatal-Exception-0.05
	>=dev-perl/Exception-Died-0.06
	dev-perl/constant-boolean
	>=dev-perl/Test-Assert-0.0501
	>=dev-perl/Exception-Base-0.2201
	>=dev-perl/Exception-System-0.11
	dev-perl/Moose"
RDEPEND="${DEPEND}"
