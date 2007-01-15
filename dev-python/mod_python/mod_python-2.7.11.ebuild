# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-2.7.11.ebuild,v 1.6 2007/01/15 19:59:55 chtekk Exp $

inherit python apache-module multilib

KEYWORDS="~amd64 x86"

DESCRIPTION="An Apache1 module providing an embedded Python interpreter."
HOMEPAGE="http://www.modpython.org/"
SRC_URI="mirror://apache/httpd/modpython/${P}.tgz"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

APACHE1_MOD_CONF="16_${PN}"
APACHE1_MOD_DEFINE="PYTHON"

DOCFILES="COPYRIGHT CREDITS NEWS README"

need_apache1

src_compile() {
	# If we dont add that, ./configure breaks this ebuild
	# because the last task (make depend) is somehow borked
	echo 'echo "configure done"' >> configure

	sed -ie 's:OPT=:OPT=$(OPTFLAGS):' "${S}/src/Makefile.in"
	sed -ie 's/\(\\"thread\\" in sys.builtin_module_names\)/int(\1)/' "${S}/configure"

	export OPTFLAGS="`/usr/sbin/apxs -q CFLAGS` -fPIC"
	econf --with-apxs=${APXS1} || die "econf failed"

	sed -ie 's:LIBEXECDIR=:LIBEXECDIR=${D}:' "Makefile"
	sed -ie 's:PY_STD_LIB=:PY_STD_LIB=${D}:' "Makefile"
	sed -ie 's:CFLAGS=$(OPT) $(INCLUDES):CFLAGS=$(OPT) $(INCLUDES) -DEAPI -O0:' "${S}/src/Makefile"
	emake || die "emake failed"
}

src_install() {
	python_version
	PY_LIBPATH="/usr/$(get_libdir)/python${PYVER}"
	dodir "${PY_LIBPATH}"

	# compileall.py is needed or make install will fail
	cp -f "${PY_LIBPATH}/compileall.py" "${D}${PY_LIBPATH}/compileall.py"
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}${PY_LIBPATH}/compileall.py"

	insinto "/usr/share/doc/${PF}/html"
	doins -r doc-html/*

	apache-module_src_install
}
