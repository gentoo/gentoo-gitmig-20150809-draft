# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-2.7.11.ebuild,v 1.1 2005/02/26 12:27:02 kloeri Exp $

inherit python apache-module

DESCRIPTION="Python module for Apache 1.x, not for Apache 2.x"
SRC_URI="mirror://apache/httpd/modpython/${P}.tgz"
HOMEPAGE="http://www.modpython.org/"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

APACHE1_MOD_CONF="${PV}/16_${PN}"
APACHE1_MOD_DEFINE="PYTHON"

DOCFILES="COPYRIGHT CREDITS NEWS README"

need_apache1

src_compile() {
	sed -ie 's:OPT=:OPT=$(OPTFLAGS):' ${S}/src/Makefile.in
	sed -ie 's/\(\\"thread\\" in sys.builtin_module_names\)/int(\1)/' ${S}/configure

	export OPTFLAGS="`/usr/sbin/apxs -q CFLAGS`"
	econf --with-apxs=${APXS1} || die "econf failed"

	sed -ie 's:LIBEXECDIR=:LIBEXECDIR=${D}:' Makefile
	sed -ie 's:PY_STD_LIB=:PY_STD_LIB=${D}:' Makefile
	sed -ie 's:CFLAGS=$(OPT) $(INCLUDES):CFLAGS=$(OPT) $(INCLUDES) -DEAPI -O0:' ${S}/src/Makefile
	emake || die "emake failed"
}

src_install() {
	python_version
	PY_LIBPATH="/usr/lib/python${PYVER}"

	dodir ${APACHE1_MODULESDIR}
	dodir ${PY_LIBPATH}

	# compileall.py is needed or make install will fail
	cp ${PY_LIBPATH}/compileall.py ${D}${PY_LIBPATH}
	emake install || die
	rm ${D}${PY_LIBPATH}/compileall.py

	insinto /usr/share/doc/${PF}/html
	doins doc-html/*
	insinto /usr/share/doc/${PF}/html/icons
	doins doc-html/icons/*

	apache-module_src_install
}
