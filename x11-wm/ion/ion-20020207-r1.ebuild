# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion/ion-20020207-r1.ebuild,v 1.6 2003/05/24 00:10:53 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A keyboard-based window manager"
SRC_URI="http://www.students.tut.fi/~tuomov/dl/${P}.tar.gz"
HOMEPAGE="http://www.students.tut.fi/~tuomov/ion/"
IUSE=""
SLOT="0"
LICENSE="Clarified-Artistic"
KEYWORDS="x86 ~ppc sparc"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die
}


src_compile() {
	# Edit system.mk
	cp system.mk system.mk.new
	sed -e 's:PREFIX=/usr/local:PREFIX=/usr:' \
		-e 's:ETCDIR=$(PREFIX)/etc:ETCDIR=/etc/X11:' \
		-e 's:$(PREFIX)/man:$(PREFIX)/share/man:' \
		-e 's:$(PREFIX)/doc:$(PREFIX)/share/doc:' \
		-e 's:#HAS_SYSTEM_ASPRINTF=1:HAS_SYSTEM_ASPRINTF=1:' \
		-e 's:#INSTALL=install -c:INSTALL=install -c:' \
		-e 's:INSTALL=install *$:#INSTALL=install:' \
		system.mk.new > system.mk

	cp Makefile Makefile.new
	sed -e 's:$(DOCDIR)/ion:$(DOCDIR)/${P}:g' Makefile.new > Makefile

	make depend || die
	emake || die
}

src_install () {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 install || die
}

pkg_postinst () {
	einfo "Configuration documentation can be found in these places:"
	einfo "/usr/share/doc/${P}/config.txt"
	einfo "http://www.students.tut.fi/~tuomov/ion/resources.html"
}
