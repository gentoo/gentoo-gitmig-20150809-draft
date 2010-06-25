# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewvc/viewvc-1.1.6.ebuild,v 1.7 2010/06/25 17:47:27 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit confutils eutils python webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="ViewVC, a web interface to CVS and Subversion"
HOMEPAGE="http://viewvc.org/"
DOWNLOAD_NUMBER="47623"
SRC_URI="http://viewvc.tigris.org/files/documents/3330/${DOWNLOAD_NUMBER}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE="cvs cvsgraph mod_python mod_wsgi mysql pygments +subversion"
SLOT="0"

DEPEND=""
RDEPEND="
	cvs? (
		dev-vcs/rcs
	)

	subversion? (
		>=dev-vcs/subversion-1.3.1[python]
	)

	mod_python? ( www-apache/mod_python )
	mod_wsgi? ( www-apache/mod_wsgi )
	!mod_python? ( !mod_wsgi? ( virtual/httpd-cgi ) )

	cvsgraph? ( >=dev-vcs/cvsgraph-1.5.0 )
	mysql? ( >=dev-python/mysql-python-0.9.0 )
	pygments? ( dev-python/pygments )
"
RESTRICT_PYTHON_ABIS="3.*"

pkg_setup() {
	python_pkg_setup
	webapp_pkg_setup

	confutils_require_any cvs subversion
}

src_prepare() {
	find bin/ -type f -print0 | xargs -0 sed -i \
		-e "s|\(^LIBRARY_DIR\)\(.*\$\)|\1 = \"$(python_get_sitedir -f)/${PN}\"|g" \
		-e "s|\(^CONF_PATHNAME\)\(.*\$\)|\1 = \"../conf/viewvc.conf\"|g"

	sed -i -e "s|\(self\.options\.template_dir\)\(.*\$\)|\1 = \"${MY_APPDIR}/templates\"|" \
		lib/config.py

	sed -i -e "s|^template_dir.*|#&|" conf/viewvc.conf.dist
	mv conf/viewvc.conf{.dist,}
	mv conf/cvsgraph.conf{.dist,}
	mv conf/mimetypes.conf{.dist,}

	python_convert_shebangs -r 2 .
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
	doins -r templates-contrib/

	if use mysql; then
		exeinto "${MY_HOSTROOTDIR}/bin"
		doexe bin/{*dbadmin,make-database,loginfo-handler}
	fi

	insinto "${MY_HOSTROOTDIR}/conf"
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

	webapp_configfile "${MY_HOSTROOTDIR}/conf/"{viewvc,cvsgraph}.conf

	webapp_src_install
}

pkg_postinst() {
	python_mod_optimize viewvc
	webapp_pkg_postinst
	elog "Now read INSTALL in /usr/share/doc/${PF} to configure ${PN}"
}

pkg_postrm() {
	python_mod_cleanup viewvc
}
