# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cpp/log4cpp-0.3.4b.ebuild,v 1.3 2002/12/12 18:47:32 george Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="Log4cpp is library of C++ classes for flexible logging to files, syslog, IDSA and other destinations. It is modeled after the Log4j Java library, staying as close to their API as is reasonable."
SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/log4cpp/${PN}-0.3.4b.tar.gz"
HOMEPAGE="http://log4cpp.sourcforge.net"

LICENSE="LGPL-2.1"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
#	make DESTDIR=${D} install || die
	make prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
}
