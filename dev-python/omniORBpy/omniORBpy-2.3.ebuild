# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/omniORBpy/omniORBpy-2.3.ebuild,v 1.2 2004/03/22 22:20:18 kloeri Exp $

DESCRIPTION="This is omniORBpy 2, a robust high-performance CORBA ORB for Python."
HOMEPAGE="http://omniorb.sourceforge.net/"
SRC_URI="mirror://sourceforge/omniorb/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND=">=net-misc/omniORB-4.0.3
	ssl? ( dev-libs/openssl )"
S="${WORKDIR}/${P}"

src_compile() {
	MY_CONF="--host=${CHOST} --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --with-omniorb=/usr"

	use ssl && MY_CONF="${MY_CONF} --with-openssl=/usr"

	MY_PY=/usr/bin/python`python -c "import sys; print sys.version[:3]"`
	# install modules for python which is default python interpreter in
	# the system

	PYTHON=${MY_PY} ./configure ${MY_CONF} || die "./configure failed"
	emake || die
}

src_install() {
	# make files are crap!
	mv mk/beforeauto.mk mk/beforeauto.mk_orig
	sed s/'prefix[\t ]*:= \/usr'/'prefix := \${DESTDIR}\/usr'/ mk/beforeauto.mk_orig > mk/beforeauto.mk
	# won't work without these really very ugly hack... maybe someone can do better..
	mv python/omniORB/dir.mk python/omniORB/dir.mk_orig
	awk -v STR="ir\\\.idl" '{ if (/^[[:space:]]*$/) flag = 0; tmpstr = $0; if (gsub(STR, "", tmpstr)) flag = 1; if (flag) print "#" $0; else print $0; }' python/omniORB/dir.mk_orig > python/omniORB/dir.mk
	mv python/dir.mk python/dir.mk_orig
	awk -v STR="Naming\\\.idl" '{ if (/^[[:space:]]*$/) flag = 0; tmpstr = $0; if (gsub(STR, "", tmpstr)) flag = 1; if (flag) print "#" $0; else print $0; }' python/dir.mk_orig > python/dir.mk
	make DESTDIR=${D} install || die

	dodoc COPYING.LIB README README.Python
	dohtml doc/omniORBpy
	dodoc doc/omniORBpy.p* # ps,pdf
	dodoc doc/tex/* # .bib, .tex

	dodir /usr/share/doc/${P}/examples
	cp -r examples/* ${D}/usr/share/doc/${P}/examples # doins doesn't do recursive
}

