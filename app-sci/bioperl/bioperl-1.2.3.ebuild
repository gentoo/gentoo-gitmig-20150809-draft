# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/bioperl/bioperl-1.2.3.ebuild,v 1.4 2004/01/09 02:55:49 sediener Exp $

inherit perl-module eutils

CATEGORY="app-sci"

DESCRIPTION="collection of tools for bioinformatics, genomics and life science research"
HOMEPAGE="http://www.bioperl.org/"
#SRC_URI="http://www.cpan.org/modules/by-module/Bio/${P}.tar.gz"
SRC_URI="http://www.bioperl.org/ftp/DIST/${P}.tar.bz2"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql gd"

DEPEND="${DEPEND}
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
	gd? ( >=dev-perl/GD-1.32-r1 )
	mysql? ( >=dev-perl/DBD-mysql-2.1004-r3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove interactiveness
	[ -n "`use mysql`" ] && epatch ${FILESDIR}/biodbgff-enable-${PV}.patch
	# want man pages in addition to perldoc documentation??
	#epatch ${FILESDIR}/domanpages-${PV}.patch
}

src_compile() {
	# there's a test to run for BioGFFDB if using mysql
	perl-module_src_compile || die "compile failed"
	# make test
##	perl-module_src_test || die "src test failed"
}

src_install() {
	mydoc="AUTHORS BUGS FAQ"
	perl-module_src_install

	# bioperl scripts and examples
	einfo 'Adding bioperl examples and scripts to /usr/share/...'
	dodir /usr/share/${PF}/scripts
	cd ${S}/scripts/
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/scripts; tar xf -)
	dodir /usr/share/${PF}/examples
	cd ${S}/examples/
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/examples; tar xf -)
	dodir /usr/share/doc/${P}
	cd ${S}
	tar cf - ./ | ( cd ${D}/usr/share/doc/${P}; tar xf -)

	# some pods in maindir
	eval `perl '-V:installvendorlib'`
	MY_SITE_LIB=${installvendorlib}/Bio
	insinto ${MY_SITE_LIB}
	doins biodatabases.pod  biodesign.pod  bioperl.pod  bioscripts.pod

	dobin bptutorial.pl

}
