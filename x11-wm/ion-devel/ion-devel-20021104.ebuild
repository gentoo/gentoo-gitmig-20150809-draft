# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion-devel/ion-devel-20021104.ebuild,v 1.4 2003/06/12 19:01:21 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A keyboard-based window manager - unstable version"
SRC_URI="http://modeemi.fi/~tuomov/dl/${P}.tar.gz"
HOMEPAGE="http://modeemi.fi/~tuomov/ion/"
DEPEND="virtual/glibc"
RDEPEND="virtual/x11"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~ppc"

pkg_setup() {
	ewarn "This package will overwrite your stable ion installation."
}

src_compile() {
	cd ${S}

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
