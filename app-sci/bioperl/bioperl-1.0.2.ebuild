# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl/bioperl-1.0.2.ebuild,v 1.3 2003/04/25 23:27:45 avenj Exp $

IUSE="mysql gd"

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="app-sci"
DESCRIPTION="The Bioperl Project is a collection of tools for bioinformatics, genomics and life science research."
SRC_URI="http://bioperl.org/DIST/${P}.tar.gz"
HOMEPAGE="http://www.bioperl.org"

LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/File-Temp
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
	dev-perl/Text-Shellwords
	gd? ( >=dev-perl/GD-1.32-r1 )
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

SLOT="0"

src_compile() {
	# there's a test to run for BioGFFDB if using mysql
	# note: these echo's are for the default values for testing. Not that we're
	# testing.
	use mysql && (
		echo y  
		echo test
		echo localhost
		echo undef
		echo undef
		) | perl-module_src_compile || perl-module_src_compile || die "compile failed"

	# Sadly, it's not advisable to run make test for this installation, as the
	# tests are used by the bioperl developers as a sort of todo list. :)  IOW,
	# it's OK if some fail.
	#perl-module_src_test || die "test failed"
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
