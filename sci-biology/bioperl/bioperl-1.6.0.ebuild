# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl/bioperl-1.6.0.ebuild,v 1.1 2009/03/13 00:41:34 weaver Exp $

EAPI="1"

inherit perl-module eutils

DESCRIPTION="Perl tools for bioinformatics - Core modules"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://www.bioperl.org/DIST/BioPerl-${PV}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-minimal graphviz"

# FIXME: Unhandled deps:
# >=dev-lang/perl-5.10.0 (includes cpan >= 1.81)
# dev-perl/SVG-Graph
# dev-perl/Ace
# dev-perl/Bio-ASN1-EntrezGene
# dev-perl/XML-DOM-XPath
# dev-perl/Convert-Binary-C
# Deprecated/unrecognized deps from 1.5 series (to be verified):
#virtual/perl-File-Temp
#dev-perl/IO-String
#dev-perl/IO-stringy
#virtual/perl-Storable
#dev-perl/libxml-perl
#dev-perl/Text-Shellwords
#~sci-libs/io_lib-1.8.12b
#!>=sci-libs/io_lib-1.9
#	gd? (
#			>=dev-perl/GD-1.32-r1
#			dev-perl/SVG
#			dev-perl/GD-SVG
#		)
#	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

DEPEND="virtual/perl-Module-Build
	dev-perl/Data-Stag
	dev-perl/libwww-perl
	!minimal? (
		dev-perl/Spreadsheet-ParseExcel
		>=dev-perl/XML-SAX-0.15
		dev-perl/Graph
		dev-perl/SOAP-Lite
		dev-perl/Array-Compare
		dev-perl/XML-Parser
		dev-perl/XML-Twig
		>=dev-perl/HTML-Parser-3.60
		>=dev-perl/XML-Writer-0.4
		dev-perl/Clone
		dev-perl/XML-DOM
		dev-perl/set-scalar
		dev-perl/XML-XPath
		dev-perl/Algorithm-Munkres
		dev-perl/Data-Stag
		dev-perl/Math-Random
		dev-perl/PostScript
		)
	graphviz? ( dev-perl/GraphViz )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/BioPerl-${PV}"

src_unpack() {
	unpack ${A}
	sed -i "/'CPAN' *=> *1.81/d" "${S}/Build.PL" || die
}

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
	         PREFIX=${D}/usr INSTALLDIRS=vendor || die
}

src_test() {
	make test || die "Tests failed."
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
