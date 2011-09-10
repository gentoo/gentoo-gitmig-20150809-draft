# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netsniff-ng/netsniff-ng-0.5.5.0.ebuild,v 1.1 2011/09/10 16:36:05 xmw Exp $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="high performance network sniffer for packet inspection"
HOMEPAGE="http://netsniff-ng.org/"
SRC_URI="http://www.${PN}.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}/src

src_prepare() {
	sed \
		-e "/CC_NORM/,+1s/gcc/$(tc-getCC)/" \
		-e "/LD_NORM/,+1s/gcc/$(tc-getCC)/" \
		-i definitions.mk || die
	echo "CFLAGS = ${CFLAGS} -std=gnu99" >> definitions.mk || die
	echo "LIBS += ${LDFLAGS}" >> definitions.mk || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../{AUTHORS,CHANGELOG,CODING,CREDITS,HACKING,README,TODO} || die
}
