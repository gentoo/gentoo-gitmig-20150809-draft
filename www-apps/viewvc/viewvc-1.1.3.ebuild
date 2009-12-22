# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewvc/viewvc-1.1.3.ebuild,v 1.1 2009/12/22 21:16:24 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit confutils eutils python webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="ViewVC, a web interface to CVS and Subversion"
HOMEPAGE="http://viewvc.org/"
SRC_URI="http://viewvc.tigris.org/files/documents/3330/47194/${P}.tar.gz"

LICENSE="viewcvs"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cvs cvsgraph mod_python mysql pygments +subversion"
SLOT="0"

DEPEND=""
RDEPEND="
	cvs? (
		>=dev-lang/python-1.5.2
		app-text/rcs
	)

	subversion? (
		>=dev-lang/python-2.0
		>=dev-util/subversion-1.3.1[python]
	)

	mod_python? ( www-apache/mod_python )
	!mod_python? ( virtual/httpd-cgi )

	cvsgraph? ( >=dev-util/cvsgraph-1.5.0 )
	mysql? ( >=dev-python/mysql-python-0.9.0 )
	pygments? ( dev-python/pygments )
"
RESTRICT_PYTHON_ABIS="3.*"

pkg_setup() {
	webapp_pkg_setup

	confutils_require_any cvs subversion
}

src_prepare() {
	find bin/ -type f -print0 | xargs -0 sed -i \
		-e "s|\(^LIBRARY_DIR\)\(.*\$\)|\1 = \"$(python_get_sitedir)/${PN}\"|g" \
		-e "s|\(^CONF_PATHNAME\)\(.*\$\)|\1 = \"../conf/viewvc.conf\"|g"

	sed -i -e "s|\(self\.options\.template_dir\)\(.*\$\)|\1 = \"${MY_APPDIR}/templates\"|" \
		lib/config.py

	sed -i -e "s|^template_dir.*|#&|" conf/viewvc.conf.dist
	mv conf/viewvc.conf{.dist,}
	mv conf/cvsgraph.conf{.dist,}
	mv conf/mimetypes.conf{.dist,}
}

src_install() {
	webapp_src_preinst

	dodoc CHANGES COMMITTERS INSTALL README

	installation() {
		insinto "$(python_get_sitedir)/${PN}"
		doins -r lib/*
	}
	python_execute_function installation

	insinto "${MY_APPDIR}"
	doins -r templates/

	if use mysql; then
		exeinto "${MY_HOSTROOTDIR}"/bin
		doexe bin/{*dbadmin,make-database,loginfo-handler}
	fi

	insinto "${MY_HOSTROOTDIR}"/conf
	doins conf/{viewvc,cvsgraph,mimetypes}.conf

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
	python_mod_optimize viewvc
	elog "Now read INSTALL in /usr/share/doc/${PF} to configure ${PN}"
}

pkg_postrm() {
	python_mod_cleanup viewvc
}
