# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioperl/bioperl-1.2.ebuild,v 1.6 2005/07/09 22:57:34 swegener Exp $

inherit perl-module debug

DESCRIPTION="A collection of tools for bioinformatics, genomics and life science research"
HOMEPAGE="http://www.bioperl.org/"
SRC_URI="http://bioperl.org/ftp/DIST/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"
IUSE="mysql gd"

DEPEND="perl-core/File-Temp
	dev-perl/Graph
	dev-perl/HTML-Parser
	dev-perl/IO-String
	dev-perl/IO-stringy
	dev-perl/Parse-RecDescent
	dev-perl/SOAP-Lite
	perl-core/Storable
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-Writer
	dev-perl/XML-Twig
	dev-perl/libxml-perl
	dev-perl/libwww-perl
	dev-perl/Text-Shellwords
	gd? ( >=dev-perl/GD-1.32-r1 )
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

# uncomment this if you'd like to access bioperl docs via man in addition to
# perldoc.
#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	echo
#	einfo " Patching to build manified pods..."
#	echo
#	patch < ${FILESDIR}/${P}-manpage.diff
#}

src_compile() {
	# note: these echo's give the default values for testing.
	use mysql && (
		echo y
		echo test
		echo localhost
		echo undef
		echo undef
		) | perl-module_src_compile || perl-module_src_compile || die "compile failed"

	# This dies at RootIO.t:
	# perl-module_src_test || die "test failed"
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install
}
