# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/viewvc/viewvc-1.0.3.ebuild,v 1.8 2007/09/06 18:55:24 beandog Exp $

inherit python eutils

SLOT="0"

DESCRIPTION="ViewVC, a web interface to CVS and Subversion"
HOMEPAGE="http://viewvc.org/"
SRC_URI="http://viewvc.tigris.org/files/documents/3330/34803/${P}.tar.gz"

LICENSE="viewcvs"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="cvs cvsgraph enscript highlight mod_python mysql subversion"

RDEPEND="
		cvs? (
			>=dev-lang/python-1.5.2
			app-text/rcs
		)

		subversion? (
			>=dev-lang/python-2.0
			>=dev-util/subversion-1.2.0
		)

		cvsgraph? ( >=dev-util/cvsgraph-1.5.0 )
		enscript? ( app-text/enscript )
		highlight? ( >=app-text/highlight-2.2.10 )
		mod_python? ( www-apache/mod_python )
		mysql? (
			>=dev-python/mysql-python-0.9.0
		)
"

pkg_setup() {
	if use subversion && ! built_with_use dev-util/subversion python ; then
		eerror "Your Subversion has been built without Python bindings"
		die "Emerge dev-util/subversion with USE=\"python\""
	fi
}

src_unpack() {
	unpack ${A} && cd ${S}

	python_version
	local LIB_DIR="/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}"
	local CONF_PATH="/usr/share/webapps/${PN}/viewvc.conf"
	find bin -type f |
		xargs sed -ie "	s|\(^LIBRARY_DIR\)\(.*\$\)|\1 = \"${LIB_DIR}\"|g
						s,\(^CONF_PATHNAME\)\(.*\$\),\1 = \"${CONF_PATH}\",g"
	sed -i "s|template_dir = templates|template_dir = /usr/share/webapps/${PN}/templates|" \
		viewvc.conf.dist
}

src_install() {
	python_version

	dodir /usr/share/webapps/${PN} /usr/share/webapps/${PN}/cgi-bin \
		/usr/share/webapps/${PN}/mod_python /usr/share/webapps/${PN}/bin \
		/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	exeinto /usr/share/webapps/${PN}/cgi-bin
	doexe bin/cgi/viewvc.cgi

	if use mysql ; then
		exeinto /usr/share/webapps/${PN}/cgi-bin
		doexe bin/cgi/query.cgi
	fi

	if use mod_python ; then
		insinto /usr/share/webapps/${PN}/mod_python
		doins bin/mod_python/viewvc.py
		doins bin/mod_python/handler.py
		doins bin/mod_python/.htaccess

		if use mysql ; then
			insinto /usr/share/webapps/${PN}/mod_python
			doins bin/mod_python/query.py
		fi
	fi

	cp -p bin/ ${D}/usr/share/webapps/${PN}/bin
	cp -rp templates ${D}/usr/share/webapps/${PN}
	cp -rp lib/* ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	insinto /usr/share/webapps/${PN}
	doins viewvc.conf.dist cvsgraph.conf.dist

	dodoc CHANGES COMMITTERS INSTALL README TODO
	dohtml -r viewvc.org/*
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/${PN}

	elog "Now read /usr/share/doc/${P}/INSTALL.gz to configure ${PN}"
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
