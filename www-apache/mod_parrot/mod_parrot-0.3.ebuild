# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_parrot/mod_parrot-0.3.ebuild,v 1.1 2005/08/15 09:04:12 mcummings Exp $
inherit eutils apache-module

DESCRIPTION="An embedded Parrot virutal machine for Apache2"
HOMEPAGE="http://www.smashing.org/mod_parrot/"
SRC_URI="http://www.smashing.org/mod_parrot/dist/${S}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

MY_PARROT_PN="0.2.3"
MY_PARROT_PATH_SUFFIX="/usr/lib/parrot"
MY_PARROT_PATH="${MY_PARROT_PATH_SUFFIX}-${MY_PARROT_PN}"

need_apache2
APACHE2_MOD_DEFINE="parrot"
APACHE2_MOD_CONF="mod_parrot"
MPLIBS_SUFFIX="${S}/"
DOCFILES="AUTHORS CHANGES LICENSE README ROADMAP"

IUSE=""
DEPEND="=dev-lang/parrot-${MY_PARROT_PN}
		>=net-www/apache-2.0.54"

src_unpack ()   {
	unpack ${A}
	cd ${S}
	#fixes missing lib for icu
	epatch ${FILESDIR}/configure.patch
}
src_compile() {

perl ./Configure.pl \
	--parrot-build-dir=${MY_PARROT_PATH} \
	--apxs=/usr/sbin/apxs2 \
	|| die "Perl ./Configure.pl failed"

emake -j1 || die "emake failed"

einfo "makeing libraries"
emake -j1 libraries || die "emake failed"

#compile the example
einfo "Compiling example"
echo "${MPLIBS_SUFFIX}lib/HelloWorld"
parrot -o ${MPLIBS_SUFFIX}lib/HelloWorld.pbc ${FILESDIR}/hello.imc

}

src_test() {
	:
}

src_install() {
	#emake install || die "install failed"
	#install the module
	apache-module_src_install

	#install the libraries + example - this is not yet supported by the Makefile (see Readme)
	einfo "Installing libraries"
	dodir /usr/lib/${P}/
	dodir /usr/lib/${P}/ModParrot
	dodir /usr/lib/${P}/ModParrot/HLL
	dodir /usr/lib/${P}/Apache
	dodir /usr/lib/${P}/examples
	dodir /usr/lib/${P}/APR

	insinto /usr/lib/${P}/ModParrot
		doins lib/ModParrot/init.pbc
	insinto /usr/lib/${P}/ModParrot/HLL
		doins lib/ModParrot/HLL/pir.pbc
		doins lib/ModParrot/HLL/pugs.pbc
	insinto /usr/lib/${P}/Apache
		doins lib/Apache/RequestRec.pbc
		doins lib/Apache/Constants.pbc
	insinto /usr/lib/${P}/APR
		doins lib/APR/Table.pbc
	insinto /usr/lib/${P}/examples
		doins lib/HelloWorld.pbc
}
