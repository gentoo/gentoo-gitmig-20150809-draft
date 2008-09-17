# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_python/mod_python-3.3.1-r1.ebuild,v 1.3 2008/09/17 09:13:08 armin76 Exp $

inherit eutils python apache-module multilib

KEYWORDS="alpha amd64 ia64 ~mips ~ppc sparc x86"

DESCRIPTION="An Apache2 module providing an embedded Python interpreter."
HOMEPAGE="http://www.modpython.org/"
SRC_URI="mirror://apache/httpd/modpython/${P}.tgz"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="16_${PN}"
APACHE2_MOD_DEFINE="PYTHON"

DOCFILES="README NEWS CREDITS"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-apr_brigade_sentinel.patch"
	# Remove optimisations, we do that outside Portage
	sed -i -e 's:--optimize 2:--no-compile:' dist/Makefile.in
}

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"
	sed -i -e 's/ -Wl,--hash-style  $//' src/Makefile
	emake OPT="`apxs2 -q CFLAGS` -fPIC" || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dohtml -r doc-html/*
	apache-module_src_install
}

src_test() {
	python_version
	cd test
	PYTHONPATH="$(ls -d ${S}/dist/build/lib.*)"
	sed -i \
		-e "120ios.environ['PYTHONPATH']=\"${PYTHONPATH}\"" \
		test.py || die "sed failed"
	"${python}" test.py || die "tests failed"
}

pkg_postinst() {
	python_version
	python_mod_optimize $(python_get_sitedir)/mod_python
	apache-module_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/mod_python
}
