# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/bonobo-python/bonobo-python-0.2.0-r1.ebuild,v 1.5 2002/07/27 06:25:36 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bonobo bindings for Python"
SRC_URI="http://bonobo-python.lajnux.nu/download/${P}.tar.gz"
HOMEPAGE="http://bonobo-python.lajnux.nu/"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/bonobo-1.0.9-r1
	>=dev-python/gnome-python-1.4.1-r2
	>=dev-python/orbit-python-0.3.0-r1
	virtual/python"
RDEPEND="${RDEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_compile() {
	PYTHON="/usr/bin/python" ./configure --host=${CHOST} --prefix=/usr \
		--with-libIDL-prefix=/usr --with-orbit-prefix=/usr \
		--with-oaf-prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS
	dodoc README TODO
}




