# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-3.0.4-r1.ebuild,v 1.2 2004/01/28 19:30:04 mr_bones_ Exp $

inherit python

DESCRIPTION="An Apache2 DSO providing an embedded Python interpreter"
HOMEPAGE="http://www.modpython.org/"
SRC_URI="http://www.apache.org/dist/httpd/modpython/${P}.tgz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/python
	>=net-www/apache-2.0"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	sed -i -e 's:mod_python.so :mod_python.so $(DESTDIR):' Makefile.in
	# remove optimisations, we do that outside portage
	sed -i -e 's:--optimize 2:--prefix=${DESTDIR}/usr --no-compile:' dist/Makefile.in

	# Fix compilation when using Python-2.3
	has_version ">=dev-lang/python-2.3" && \
		sed -i -e 's:LONG_LONG:PY_LONG_LONG:g' \
		"${S}/src/requestobject.c"
}

src_compile() {
	./configure --with-apxs=/usr/sbin/apxs2 || die
	make OPT="`apxs2 -q CFLAGS` -fPIC" || die
}

src_install() {
	dodir /usr/lib/apache2-extramodules
	make install DESTDIR=${D} LIBEXECDIR=/usr/lib/apache2-extramodules || die
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/16_mod_python.conf
	dodoc ${FILESDIR}/16_mod_python.conf README NEWS CREDITS COPYRIGHT
	dohtml doc-html/*
	insinto /usr/share/doc/${P}/html/icons
	doins doc-html/icons/*
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/mod_python

	einfo "To have Apache run python programs, please do the following:"
	einfo "Edit /etc/conf.d/apache2 and add \"-D PYTHON\""
	einfo "That will setup Apache to load python when it starts."
	einfo
	einfo "If you're new to mod_python there's a manual and tutorial"
	einfo "installed in /usr/share/doc/${P}/html/index.html."
}

pkg_postrm() {
	python_mod_cleanup
}
