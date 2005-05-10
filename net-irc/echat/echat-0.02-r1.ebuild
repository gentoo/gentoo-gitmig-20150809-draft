# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/echat/echat-0.02-r1.ebuild,v 1.6 2005/05/10 22:36:40 swegener Exp $

DESCRIPTION="Console vypress chat clone for *nix like systems."
HOMEPAGE="http://echat.deep.perm.ru/"
SRC_URI="http://echat.deep.perm.ru/files/${P}f2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${P}f2

src_compile() {
	local lang

	# default is english
	lang="-DEN"
	[ "${LANG}" == "ru_RU" ] && lang="-DRU"
	[ "${LANG}" == "tr" ] || [ "${LANG}" == "tr_TR" ] && lang="-DTU"

	sed -i \
		-e "s:PREFIX=/usr/local:PREFIX=/usr:g" \
		-e "s:CFLAGS=-Wall -g -O2:CFLAGS=${CFLAGS}:g" \
		-e "s:DEFINES=-DLINUX -DEN -DCHARSET:DEFINES=-DLINUX ${lang} -DCHARSET:g" \
		Makefile || die "Sed failed"

	emake || die
}

src_install() {
	local doc

	[ "${LANG}" == "ru_RU" ] && doc=".ru"
	[ "${LANG}" == "tr" ] || [ "${LANG}" == "tr_TR" ] && doc=".tu"

	mv .echatrc.sample dot.echatrc
	dobin echat || die
	dodoc NEWS dot.echatrc README${doc}
}
