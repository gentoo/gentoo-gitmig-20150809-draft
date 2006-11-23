# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/lxr/lxr-0.9.4-r1.ebuild,v 1.2 2006/11/23 17:14:56 vivo Exp $

inherit webapp multilib eutils

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
		mysql? ( >=virtual/mysql-4.0 dev-perl/DBD-mysql )
"
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/initdb-mysql.patch
}

src_install() {
	webapp_src_preinst
	# install perl module. stolen from dev-perl/PDL
	eval `perl '-V:version'`
	PERLVERSION=${version}
	eval `perl '-V:archname'`
	ARCHVERSION=${archname}
	local PERLDIR="/usr/$(get_libdir)/perl5/vendor_perl/${PERLVERSION}/${ARCHVERSION}"
	dodir ${PERLDIR} /usr/bin
	mv Local.pm ${D}${PERLDIR}
	cp -r lib/LXR ${D}${PERLDIR}
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
