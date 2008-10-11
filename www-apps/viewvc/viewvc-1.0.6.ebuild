# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewvc/viewvc-1.0.6.ebuild,v 1.1 2008/10/11 20:28:07 wrobel Exp $

inherit confutils webapp python eutils

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="ViewVC, a web interface to CVS and Subversion"
HOMEPAGE="http://viewvc.org/"
SRC_URI="http://viewvc.tigris.org/files/documents/3330/43677/${P}.tar.gz"

LICENSE="viewcvs"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cvs cvsgraph enscript highlight mod_python mysql subversion"
SLOT="0"

DEPEND=""
RDEPEND="
	cvs? (
		>=dev-lang/python-1.5.2
		app-text/rcs
	)

	subversion? (
		>=dev-lang/python-2.0
		>=dev-util/subversion-1.2.0
	)

	mod_python? ( www-apache/mod_python )
	!mod_python? ( virtual/httpd-cgi )

	cvsgraph? ( >=dev-util/cvsgraph-1.5.0 )
	enscript? ( app-text/enscript )
	highlight? ( >=app-text/highlight-2.2.10 )
	mysql? ( >=dev-python/mysql-python-0.9.0 )
"

pkg_setup() {
	webapp_pkg_setup

	confutils_require_any cvs subversion
	confutils_use_depend_built_with_all subversion dev-util/subversion python

	python_version
	MOD_PATH=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	find bin/ -type f -print0 | xargs -0 sed -i \
		-e "s|\(^LIBRARY_DIR\)\(.*\$\)|\1 = \"${MOD_PATH}\"|g" \
		-e "s|\(^CONF_PATHNAME\)\(.*\$\)|\1 = \"../conf/viewvc.conf\"|g"

	sed -i -e "s|\(self\.options\.template_dir\)\(.*\$\)|\1 = \"${MY_APPDIR}/templates\"|" \
		lib/config.py

	sed -i -e "s|^template_dir.*|#&|" viewvc.conf.dist
	mv viewvc.conf{.dist,}
	mv cvsgraph.conf{.dist,}
}

src_install() {
	webapp_src_preinst
	python_version

	dodoc CHANGES COMMITTERS INSTALL README TODO
	dohtml -r viewvc.org/*

	insinto "${MOD_PATH}"
	doins -r lib/*

	insinto "${MY_APPDIR}"
	doins -r templates/

	if use mysql; then
		exeinto "${MY_HOSTROOTDIR}"/bin
		doexe bin/{*dbadmin,make-database,loginfo-handler}
	fi

	insinto "${MY_HOSTROOTDIR}"/conf
	doins {viewvc,cvsgraph}.conf

	if use mod_python; then
		insinto "${MY_HTDOCSDIR}"
		doins bin/mod_python/viewvc.py
		doins bin/mod_python/handler.py
		doins bin/mod_python/.htaccess
		use mysql && doins bin/mod_python/query.py
	else
		exeinto "${MY_CGIBINDIR}"
		doexe bin/cgi/viewvc.cgi
		use mysql && doexe bin/cgi/query.cgi
	fi

	webapp_configfile "${MY_HOSTROOTDIR}"/conf/{viewvc,cvsgraph}.conf

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	python_version
	python_mod_optimize "${MOD_PATH}"
	elog "Now read INSTALL in /usr/share/doc/${PF} to configure ${PN}"
}

pkg_postrm() {
	python_mod_cleanup
}
