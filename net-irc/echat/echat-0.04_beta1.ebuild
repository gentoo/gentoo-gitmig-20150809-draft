# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/echat/echat-0.04_beta1.ebuild,v 1.7 2005/05/10 22:36:40 swegener Exp $

inherit eutils

MY_P=${P/_}

DESCRIPTION="Console vypress chat clone for *nix like systems."
HOMEPAGE="http://echat.deep.perm.ru/"
SRC_URI="http://echat.deep.perm.ru/files/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~s390 ~ppc"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${MY_P}

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
	dobin ec
}
