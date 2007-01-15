# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-3.1.4-r1.ebuild,v 1.12 2007/01/15 19:59:55 chtekk Exp $

inherit python eutils apache-module multilib autotools

KEYWORDS="alpha amd64 ia64 ppc sparc x86"

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

DOCFILES="README NEWS CREDITS COPYRIGHT"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove optimisations, we do that outside Portage
	sed -ie 's:--optimize 2:--no-compile:' "dist/Makefile.in"

	# Fix compilation when using Python 2.3 or newer
	if has_version ">=dev-lang/python-2.3" ; then
		sed -ie 's:LONG_LONG:PY_LONG_LONG:g' "${S}/src/requestobject.c"
	fi

	# Fix configure with Bash 3.1
	epatch "${FILESDIR}/${P}-configure-bash-3.1.patch"
	eautoconf
}

src_compile() {
	econf --with-apxs=${APXS2} || die "econf failed"
	emake OPT="`apxs2 -q CFLAGS` -fPIC" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dohtml -r doc-html/*
	apache-module_src_install
}

pkg_postinst() {
	python_version
	python_mod_optimize "/usr/$(get_libdir)/python${PYVER}/site-packages/mod_python"
	apache-module_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup
}
