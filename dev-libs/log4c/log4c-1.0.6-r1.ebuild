# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.6-r1.ebuild,v 1.3 2002/08/01 18:46:28 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://www.cimai.com/opensource/log4c/index.html"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND=">=dev-libs/expat-1.95.2
	>=app-doc/doxygen-1.2.15
	>=media-gfx/graphviz-1.7.15-r2
	>=app-text/tetex-1.0.7-r9"

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
