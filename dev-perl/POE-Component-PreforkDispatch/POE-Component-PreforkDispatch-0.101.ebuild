# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-PreforkDispatch/POE-Component-PreforkDispatch-0.101.ebuild,v 1.1 2009/06/23 07:45:36 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="EWATERS"

inherit perl-module

DESCRIPTION="No description available"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Error
	dev-perl/IO-Capture
	dev-perl/Params-Validate
	dev-perl/POE"
RDEPEND="${DEPEND}"
