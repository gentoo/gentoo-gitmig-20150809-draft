# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4c/log4c-1.0.10-r1.ebuild,v 1.7 2005/07/10 20:28:14 swegener Exp $

inherit eutils

DESCRIPTION="Log4c is a library of C for flexible logging to files, syslog and other destinations. It is modeled after the Log for Java library (http://jakarta.apache.org/log4j/), staying as close to their API as is reasonable."
SRC_URI="mirror://sourceforge/log4c/${P}.tar.gz"
HOMEPAGE="http://log4c.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc"

# The virtual/logger
# could probably be deleted, but it just doesn't seem right to have log4c
# without a logger underneath it.

RDEPEND=">=dev-libs/expat-1.95.2
	>=media-gfx/graphviz-1.7.15-r2
	virtual/logger"

DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.2.15 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	if use doc;
	then
		epatch ${FILESDIR}/makefile.doc.in.patch ||  die "patch failed"
		epatch ${FILESDIR}/makefile.doc.am.patch ||  die "patch failed"
	else
		### comment out the docs with this patch to minimize depenencies
		epatch ${FILESDIR}/${P}-nodocs.patch || die "patch failed"
	fi
	# fixes gcc-3.4 problems
	epatch ${FILESDIR}/log4c-1.0.11-function.patch || die "patch failed"
	epatch ${FILESDIR}/log4c_1.0.11_test.patch || die "patch failed"
}

src_compile() {
	econf --enable-test || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	# Currently with this ebuild you have to have a /etc/log4crc file and
	# have LOG4C_RCPATH defined or log4c quitely does nothing
	cp ${D}/etc/log4crc.sample ${D}/etc/log4crc
	dodir /etc/env.d
	echo "LOG4C_RCPATH=/etc" > ${D}/etc/env.d/42${PN} || die
}
