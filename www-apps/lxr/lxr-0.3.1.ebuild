# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/lxr/lxr-0.3.1.ebuild,v 1.5 2007/07/02 14:35:38 peper Exp $

inherit webapp

S=${WORKDIR}/${P%.?}

DESCRIPTION="A general purpose source code indexer and cross-referencer that provides web-based browsing of source code with links to the definition and usage of any identifier."
HOMEPAGE="http://sourceforge.net/projects/lxr"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ppc"

RESTRICT="mirror"
IUSE=""

# Glimpse is actually optional, but since there is no USE flag, require it
RDEPEND="app-misc/glimpse
	     dev-lang/perl
		 >=virtual/perl-DB_File-1.807"
DEPEND=${RDEPEND}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# prepare ${D} for our arrival
	webapp_src_preinst

	# Install documentation
	dodoc COPYING INSTALL README

	# Makefile macros
	PERLBIN=`which perl`
	INSTALLPREFIX=${D}/usr

	# Install
	#
	# first we do it LXR's way ...
	make install INSTALLPREFIX=${INSTALLPREFIX} PERLBIN=${PERLBIN}

	# and now we do it our way
	cp -R ${INSTALLPREFIX}/http/* ${D}${MY_HTDOCSDIR}
	rm -rf ${INSTALLPREFIX}/http
	rm -rf ${INSTALLPREFIX}/source

	# Identify the configuration files that this app uses
	webapp_configfile ${MY_HTDOCSDIR}/lxr.conf

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	for x in find ident search diff source; do
		webapp_runbycgibin perl ${MY_HTDOCSDIR}/$x
	done

	# Add the post-installation instructions
	webapp_postinst_txt en INSTALL

	# Fix perms on genxref
	fperms o+rx /usr/bin/genxref

	# Let webapp.eclass do the rest
	webapp_src_install
}
