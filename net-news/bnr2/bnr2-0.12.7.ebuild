# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/bnr2/bnr2-0.12.7.ebuild,v 1.5 2004/07/14 02:26:52 vapier Exp $

DESCRIPTION="A great newsreader for alt.binaries.*"
HOMEPAGE="http://www.bnr2.org/"
SRC_URI="http://www.bnr2.org/BNR2beta-${PV}.tgz
	http://www.bnr2.org/libborqt-6.9.0-qt2.3.so.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/x11
	virtual/libc"

S=${WORKDIR}/BNR2

src_install() {
	dodir /opt/bnr2
	cp -r * ${D}/opt/bnr2/
	rm ${D}/opt/bnr2/bin/bnr2
	dobin ${FILESDIR}/bnr2
	dodir /usr/share/doc/${PF}
	mv ${D}/opt/bnr2/docs/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/opt/bnr2/docs
}
