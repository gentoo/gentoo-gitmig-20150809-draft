# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.10-r1.ebuild,v 1.3 2004/12/04 04:00:18 dragonheart Exp $

inherit eutils

DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="mirror://sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://log4c.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~sparc ppc ~amd64"
IUSE="doc"

# This is the last version of log4c that uses 'expat' and the last one I could
# get working with a gcc 3.3.4 gentoo box.  Later version work okay on 
# redhat boxes, but the ones I had around we're gcc 3.2.  The virtual/logger
# could probably be deleted, but it just doesn't seem right to have log4c
# without a logger underneath it.

DEPEND=">=dev-libs/expat-1.95.2
	>=media-gfx/graphviz-1.7.15-r2"

RDEPEND="virtual/logger
	>=dev-libs/expat-1.95.2
	>=media-gfx/graphviz-1.7.15-r2"


src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	### comment out the docs with this patch to minimize depenencies
	useq doc || epatch ${FILESDIR}/${P}-nodocs.patch
	epatch ${FILESDIR}/log4c-1.0.11-function.patch  || die "failed to patch"
}

src_compile() {

	econf --enable-test || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README
	# Currently with this ebuild you have to have a /etc/log4crc file and
	# have LOG4C_RCPATH defined or log4c quitely does nothing
	cp ${D}/etc/log4crc.sample ${D}/etc/log4crc
	dodir /etc/env.d
	echo "LOG4C_RCPATH=/etc" > ${D}/etc/env.d/42${PN} || die
}
