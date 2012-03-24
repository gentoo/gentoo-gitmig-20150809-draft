# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl/bioperl-1.5.1-r1.ebuild,v 1.11 2012/03/24 19:44:30 armin76 Exp $

inherit perl-module eutils

DESCRIPTION="Perl tools for bioinformatics - Core modules"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://www.bioperl.org/DIST/${P}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="mysql gd"

DEPEND="
	virtual/perl-File-Temp
	dev-perl/HTML-Parser
	dev-perl/IO-String
	dev-perl/IO-stringy
	dev-perl/SOAP-Lite
	virtual/perl-Storable
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-Writer
	dev-perl/XML-Twig
	dev-perl/libxml-perl
	dev-perl/libwww-perl
	dev-perl/Graph
	dev-perl/Text-Shellwords
	~sci-libs/io_lib-1.8.12b
	!>=sci-libs/io_lib-1.9
	gd? (
			>=dev-perl/GD-1.32-r1
			dev-perl/SVG
			dev-perl/GD-SVG
		)
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
	         PREFIX=${D}/usr INSTALLDIRS=vendor
}

src_test() {
	make test || die "Tests failed."
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
