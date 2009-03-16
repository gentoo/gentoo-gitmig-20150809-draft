# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl-network/bioperl-network-9999.ebuild,v 1.1 2009/03/16 23:26:44 weaver Exp $

EAPI="2"

inherit perl-module subversion

DESCRIPTION="Perl tools for bioinformatics - Analysis of protein-protein interaction networks"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI=""
ESVN_REPO_URI="svn://code.open-bio.org/bioperl/${PN}/trunk"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"
SRC_TEST="do"

DEPEND="virtual/perl-Module-Build
	>=sci-biology/bioperl-${PV}
	>=dev-perl/Graph-0.86"

RDEPEND="${DEPEND}"

S="${WORKDIR}/BioPerl-network-${PV}"

src_install() {
	mydoc="AUTHORS BUGS"
	perl-module_src_install
}
