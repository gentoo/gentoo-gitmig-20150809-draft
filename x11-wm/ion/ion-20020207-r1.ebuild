# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion/ion-20020207-r1.ebuild,v 1.11 2005/07/10 15:19:56 twp Exp $

inherit eutils

DESCRIPTION="A keyboard-based window manager"
HOMEPAGE="http://www.students.tut.fi/~tuomov/ion/"
SRC_URI="http://www.students.tut.fi/~tuomov/dl/${P}.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
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
		-e 's:-pedantic-errors ::g' \
		system.mk.new > system.mk

	cp Makefile Makefile.new
	sed -e 's:$(DOCDIR)/ion:$(DOCDIR)/${P}:g' \
		Makefile.new > Makefile

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
