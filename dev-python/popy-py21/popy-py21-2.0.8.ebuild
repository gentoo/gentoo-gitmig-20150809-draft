# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/popy-py21/popy-py21-2.0.8.ebuild,v 1.3 2004/08/20 20:58:15 pythonhead Exp $

MY_P="PoPy-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="PostgreSQL database adapter for the Python"
HOMEPAGE="http://popy.sourceforge.net/"
SRC_URI="http://www.zope.org/Members/tm/PoPy/${PV}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=dev-lang/python-2.1*
	>=dev-python/egenix-mx-base-py21-2.0.4
	>=dev-db/postgresql-7.1.3"

src_compile() {
	./configure \
		--with-mxdatetime-headers=/usr/lib/python2.1/site-packages/mx/DateTime/mxDateTime \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-postgres-includes=/usr/include/postgresql/server \
		--mandir=/usr/share/man \
		--with-python=/usr/bin/python2.1 \
		--with-python-version=2.1 || die "./configure failed"
	emake || die
}

src_install () {
	cd ${S}
	[ -f "Makefile.orig" ] && die
	mv Makefile Makefile.orig
	sed \
		-e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
		-e 's:\($(INSTALL) -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' Makefile.orig > Makefile
	make install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL README
}

