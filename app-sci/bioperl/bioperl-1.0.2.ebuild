# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl/bioperl-1.0.2.ebuild,v 1.9 2004/10/30 15:28:15 ribosome Exp $

inherit perl-module
CATEGORY="app-sci"

DESCRIPTION="collection of tools for bioinformatics, genomics and life science research"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://bioperl.org/DIST/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="mysql gd"

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
