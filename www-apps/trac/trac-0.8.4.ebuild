# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac/trac-0.8.4.ebuild,v 1.2 2005/06/21 22:12:12 hansmi Exp $

inherit distutils webapp

DESCRIPTION="Trac is a minimalistic web-based project management, wiki and bug/issue tracking system."
HOMEPAGE="http://trac.edgewall.com/"
SRC_URI="http://ftp.edgewall.com/pub/trac/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="vhosts"

DEPEND="$DEPEND
	>=dev-lang/python-2.3
	>=dev-python/docutils-0.3.3
	=dev-db/sqlite-2.8*
	<=dev-python/pysqlite-1.0
	>=dev-libs/clearsilver-0.9.3
	app-text/silvercity
	>=dev-util/subversion-1.0.3"

POSTINST_PV="0.8.1"

# need choice between enscript/silvercity/nothing
# need choice between sqlite-3 + pysqlite-1.1 / sqlite-2.8 + pysqlite-1.0
# need choice between mod_python/nothing
#
# NOTE: could someone please enlight me in why ${who} wrote those notes above?
# What's been ${who}'s goals? -- trapni (2005-06-02 07:17 UTC)

DOCS="AUTHORS COPYING ChangeLog INSTALL MANIFEST.in PKG-INFO README README.tracd RELEASE THANKS UPGRADE"

src_install () {
	# project databases go in here
	dodir /var/lib/trac

	webapp_src_preinst
	distutils_src_install
	dodoc ${DOCS}

	# now, we have to turn this into something that webapp-config can use

	local my_dir=${D}/usr/share/trac
	mv ${my_dir}/cgi-bin/trac.cgi ${D}${MY_CGIBINDIR} || die
	rm -rf ${my_dir}/cgi-bin || die
	mv ${my_dir}/htdocs/* ${D}${MY_HTDOCSDIR} || die
	rm -rf ${my_dir}/htdocs || die

	for lang in en; do
		webapp_postinst_txt ${lang} ${FILESDIR}/${POSTINST_PV}-postinst-${lang}.txt
	done

	# the trac dir itself needs to be server-owned
	# this should do the trick

	webapp_serverowned ${MY_HTDOCSDIR}

	# okay, we're done - let webapp.eclass finish off
	webapp_src_install
}
