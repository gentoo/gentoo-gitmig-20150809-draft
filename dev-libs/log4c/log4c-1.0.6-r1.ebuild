# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.6-r1.ebuild,v 1.16 2004/07/14 14:58:50 agriffis Exp $

DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="mirror://sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://www.cimai.com/opensource/log4c/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=dev-libs/expat-1.95.2
	>=app-doc/doxygen-1.2.15
	>=media-gfx/graphviz-1.7.15-r2
	virtual/tetex"

src_compile() {

	econf || die

	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
