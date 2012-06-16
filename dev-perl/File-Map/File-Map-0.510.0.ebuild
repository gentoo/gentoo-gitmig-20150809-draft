# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Map/File-Map-0.510.0.ebuild,v 1.1 2012/06/16 19:56:54 bicatali Exp $

EAPI=4

MODULE_AUTHOR="LEONT"
MODULE_VERSION=0.51

inherit perl-module

DESCRIPTION="Memory mapping made simple and safe."

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Const-Fast
	dev-perl/PerlIO-Layers
	dev-perl/Sub-Exporter"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
			dev-perl/Test-Exception
			dev-perl/Test-NoWarnings
			dev-perl/Test-Warn
		   )"
