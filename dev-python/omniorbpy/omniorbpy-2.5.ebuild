# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/omniorbpy/omniorbpy-2.5.ebuild,v 1.2 2004/11/17 21:21:36 mr_bones_ Exp $

inherit eutils python

MY_P=${P/omniorb/omniORB}
S=${WORKDIR}/${MY_P}

DESCRIPTION="This is omniORBpy 2, a robust high-performance CORBA ORB for Python."
HOMEPAGE="http://omniorb.sourceforge.net/"
SRC_URI="mirror://sourceforge/omniorb/${MY_P}.tar.gz http://www-lce.eng.cam.ac.uk/~acnt2/code/omniORBpy-2.4-newstyleobjs02.patch"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ssl"

DEPEND=">=net-misc/omniORB-4.0.5
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	sed -i -e "s/^CXXDEBUGFLAGS.*/CXXDEBUGFLAGS = ${CXXFLAGS}/" \
		-e "s/^CDEBUGFLAGS.*/CDEBUGFLAGS = ${CFLAGS}/" \
		${S}/mk/beforeauto.mk.in
	cd ${S}
	epatch ${DISTDIR}/omniORBpy-2.4-newstyleobjs02.patch
}

src_compile() {
	use ssl && MY_CONF="${MY_CONF} --with-openssl=/usr"

	python_version
	MY_PY=/usr/bin/python$PYVER

	PYTHON=${MY_PY} econf \
		--with-omniorb=/usr \
		${MYCONF} || die "./configure failed"

	emake || die " make failed"
}

src_install() {
	# make files are crap!
	sed -i -e "s/'prefix[\t ]*:= \/usr'/'prefix := \${DESTDIR}\/usr'/" \
		mk/beforeauto.mk

	# won't work without these really very ugly hack... 
	# maybe someone can do better..

	mv python/omniORB/dir.mk python/omniORB/dir.mk_orig
	awk -v STR="ir\\\.idl" '{ if (/^[[:space:]]*$/) flag = 0; tmpstr = $0; if (gsub(STR, "", tmpstr)) flag = 1; if (flag) print "#" $0; else print $0; }' python/omniORB/dir.mk_orig > python/omniORB/dir.mk
	mv python/dir.mk python/dir.mk_orig
	awk -v STR="Naming\\\.idl" '{ if (/^[[:space:]]*$/) flag = 0; tmpstr = $0; if (gsub(STR, "", tmpstr)) flag = 1; if (flag) print "#" $0; else print $0; }' python/dir.mk_orig > python/dir.mk

	make DESTDIR=${D} install || die " install failed"

	dodoc COPYING.LIB README README.Python
	dohtml doc/omniORBpy
	dodoc doc/omniORBpy.p* # ps,pdf
	dodoc doc/tex/* # .bib, .tex

	dodir /usr/share/doc/${P}/examples
	cp -r examples/* ${D}/usr/share/doc/${P}/examples # doins doesn't do recursive
}

