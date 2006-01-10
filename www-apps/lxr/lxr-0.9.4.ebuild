# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/lxr/lxr-0.9.4.ebuild,v 1.1 2006/01/10 20:38:07 rl03 Exp $

inherit webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

DESCRIPTION="A general purpose source code indexer and cross-referencer that provides web-based browsing of source code with links to the definition and usage of any identifier."
HOMEPAGE="http://sourceforge.net/projects/lxr"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE="cvs freetext mysql postgres"

RDEPEND="dev-util/ctags
		net-www/apache
		freetext? ( >=www-apps/swish-e-2.1 )
		dev-lang/perl
		dev-perl/DBI
		dev-perl/File-MMagic
		cvs? ( app-text/rcs )
		postgres? ( dev-db/postgresql dev-perl/DBD-Pg )
		mysql? ( >=dev-db/mysql-4 dev-perl/DBD-mysql )
"

src_install() {
	webapp_src_preinst
	# install perl module. stolen from dev-perl/PDL
	eval `perl '-V:version'`
	PERLVERSION=${version}
	eval `perl '-V:archname'`
	ARCHVERSION=${archname}
	dodir /usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION} /usr/bin
	mv Local.pm ${D}/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}
	cp -r lib/LXR ${D}/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}
	sed "s|/usr/local/bin/swish-e|/usr/bin/swish-e|
		s|/usr/bin/ctags|/usr/bin/exuberant-ctags|
		s|'glimpse|#'glimpse|g
		s|/path/to/lib/|/usr/lib/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}/|g" -i templates/lxr.conf

	dodoc BUGS CREDITS.txt HACKING INSTALL notes .htaccess* swish-e.conf

	local files="diff find fixhashbang ident search source genxref
		.htaccess* templates/* genjavaclasses"
	cp ${files} ${D}/${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/lxr.conf
	webapp_sqlscript mysql initdb-mysql
	webapp_sqlscript postgresql initdb-postgres
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_src_install
}
