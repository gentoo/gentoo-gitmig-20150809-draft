# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-3.1.4-r1.ebuild,v 1.1 2005/07/06 10:50:26 liquidx Exp $

inherit python eutils apache-module

DESCRIPTION="An Apache2 DSO providing an embedded Python interpreter"
HOMEPAGE="http://www.modpython.org/"
SRC_URI="mirror://apache/httpd/modpython/${P}.tgz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"
IUSE=""
DEPEND="dev-lang/python"

#APACHE2_MOD_CONF="2.7.11/16_${PN}"
APACHE2_MOD_DEFINE="PYTHON"

DOCFILES="README NEWS CREDITS COPYRIGHT"

need_apache2

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd \$S failed"

	# remove optimisations, we do that outside portage
	sed -ie 's:--optimize 2:--no-compile:' dist/Makefile.in

	# Fix compilation when using Python-2.3
	if has_version ">=dev-lang/python-2.3"; then
		sed -ie 's:LONG_LONG:PY_LONG_LONG:g' "${S}/src/requestobject.c"
	fi
}

src_compile() {
	econf --with-apxs=${APXS2} || die
	emake OPT="`apxs2 -q CFLAGS` -fPIC" || die
}

src_install() {
	emake DESTDIR=${D} install || die

	dohtml doc-html/*
	insinto /usr/share/doc/${PF}/html/icons
	doins doc-html/icons/*

	apache-module_src_install
	insinto ${APACHE2_MODULES_CONFDIR}
	newins ${FILESDIR}/16_${PN}-r1.conf 16_${PN}.conf
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/mod_python
	apache-module_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup
}
