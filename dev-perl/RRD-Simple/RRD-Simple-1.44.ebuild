# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RRD-Simple/RRD-Simple-1.44.ebuild,v 1.1 2010/12/10 12:19:36 chainsaw Exp $

EAPI="2"

MODULE_AUTHOR="NICOLAW"

inherit perl-module

DESCRIPTION="Simple interface to create and store data in RRD files"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	virtual/perl-Module-Build"
RDEPEND="dev-perl/Test-Deep
	net-analyzer/rrdtool"
