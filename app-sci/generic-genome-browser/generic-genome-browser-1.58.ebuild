# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/generic-genome-browser/generic-genome-browser-1.58.ebuild,v 1.2 2004/01/14 04:40:13 sediener Exp $

inherit perl-module

CATEGORY="app-sci"

MY_PN="Generic-Genome-Browser"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The generic genome browser provides a display of genomic annotations on interactive web pages"
HOMEPAGE="http://www.gmod.org"
SRC_URI="mirror://sourceforge/gmod/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql gd"

S="${WORKDIR}/${MY_P}"

DEPEND="
	>=app-sci/bioperl-1.4
	>=dev-perl/CGI-2.56
	>=dev-perl/GD-2.07
	dev-perl/DBI
	dev-perl/Digest-MD5
	dev-perl/Text-Shellwords
	dev-perl/libwww-perl
	dev-perl/XML-Parser
	dev-perl/XML-Writer
	dev-perl/XML-Twig
	dev-perl/XML-DOM
	dev-perl/Bio-Das
	gd? (
			dev-perl/GD-SVG
		)
	mysql?
		(
			>=dev-db/mysql-4
			dev-perl/DBD-mysql
		)
	>=net-www/apache-2.0.47"

RDEPEND="${DEPEND}"


src_compile() {

	cd ${S}
#	ewarn "Modifying Makefile.PL to avoid sandbox violation"
	sed -e "s:WriteMakefile(:WriteMakefile(\n 'PREFIX'=>'${D}/usr',\n'INSTALLDIRS'  => 'vendor',:" -i Makefile.PL

	perl Makefile.PL \
			HTDOCS=/var/www/localhost/htdocs \
			CGIBIN=/var/www/localhost/cgi-bin \
			CONF=/etc \
			PREFIX=/var/www/localhost \
			DESTDIR=${D} \
			INSTALLDIRS=vendor
	#perl-module_src_compile || die "Make failed"
	perl-module_src_test || die "Test Failed"
}

src_install() {
	dodir /etc
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin
	mydoc="History README TODO INSTALL"
	dodir /usr/share/${PF}/tutorial
	cd ${S}/docs/tutorial
	tar cf - ./ | ( cd ${D}/usr/share/${PF}/scripts; tar xf -)
	cd ${S}
	sed -e "s:my \$dir = \":my \$dir = \"${D}/:" -i install_util/conf_install.PLS
	sed -e "s:my \$ht_target = \":my \$ht_target = \"${D}/:" -i install_util/htdocs_install.PLS
	sed -e "s:my \$cgi_target = :my \$cgi_target = \"${D}\"\.:" -i install_util/cgi_install.PLS

	perl-module_src_install
}


