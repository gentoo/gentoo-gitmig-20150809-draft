# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl-db/bioperl-db-9999.ebuild,v 1.2 2009/05/13 15:51:12 weaver Exp $

EAPI="2"

inherit perl-module subversion

DESCRIPTION="Perl tools for bioinformatics - Perl API that accesses the BioSQL schema"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI=""
ESVN_REPO_URI="svn://code.open-bio.org/bioperl/${PN}/trunk"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND=">=sci-biology/bioperl-${PV}
	dev-perl/DBI
	sci-biology/biosql"
DEPEND="virtual/perl-Module-Build
	${CDEPEND}"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/BioPerl-db-${PV}"

src_configure() {
	# This disables tests. TODO: Enable tests
	sed -i -e '/biosql_conf();/d' \
		-e '/skip.*DBHarness.biosql.conf/d' "${S}/Build.PL" || die
	perl-module_src_configure
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
