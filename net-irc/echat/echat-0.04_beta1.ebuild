# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/echat/echat-0.04_beta1.ebuild,v 1.1 2004/03/06 13:40:09 zul Exp $

DESCRIPTION="Console vypress chat clone for *nix like systems."
HOMEPAGE="http://deep.perm.ru/echat/"
SRC_URI="http://files.akl.lt/~x11/${P}.tar.gz
	    http://gsk.vtu.lt:8080/~arturaz/soft/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
		sys-libs/ncurses"
RDEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-reuseaddr.patch
}

src_compile() {
	local lang

	# default is english
	lang="-DEN"
	[ "${LANG}" == "ru_RU" ] && lang="-DRU"
	[ "${LANG}" == "tr" ] || [ "${LANG}" == "tr_TR" ] && lang="-DTU"

	sed -i \
		-e "s:PREFIX=/usr/local:PREFIX=/usr:g" \
		-e "s:CFLAGS=-Wall -g -O2:CFLAGS=-Wall -g ${CFLAGS}:g" \
		-e "s:DEFINES=-DFREEBSD -DCHARSET:DEFINES=-DLINUX ${lang} -DCHARSET -DPORTREUSE:g" \
		Makefile || die "Sed magic failed!"

	emake || die
}

src_install() {
	dobin echat || die

	cd ${S}/doc
	mv .echatrc.sample dot.echatrc.sample
	dodoc NEWS dot.echatrc.sample README* TODO
	insinto /etc
	newins dot.echatrc.sample echatrc
	doman *.1
	exeinto /usr/bin/
	doexe ec
}
