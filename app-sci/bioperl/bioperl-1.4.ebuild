# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl/bioperl-1.4.ebuild,v 1.7 2004/08/03 11:47:22 dholm Exp $

inherit perl-module eutils

CATEGORY="app-sci"

DESCRIPTION="collection of tools for bioinformatics, genomics and life science research"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://www.bioperl.org/ftp/DIST/${P}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~ppc"
IUSE="mysql gd"

DEPEND="
	dev-perl/File-Temp
	dev-perl/HTML-Parser
	dev-perl/IO-String
	dev-perl/IO-stringy
	dev-perl/SOAP-Lite
	dev-perl/Storable
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-Writer
	dev-perl/XML-Twig
	dev-perl/libxml-perl
	dev-perl/libwww-perl
	dev-perl/Graph
	dev-perl/Text-Shellwords
	gd? (
			>=dev-perl/GD-1.32-r1
			dev-perl/SVG
			dev-perl/GD-SVG
		)
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

RDEPEND="${DEPEND}"

src_compile() {
	yes "" | perl Makefile.PL ${myconf} \
	         PREFIX=${D}/usr INSTALLDIRS=vendor
	#perl-module_src_test || die "Test Failed"
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
