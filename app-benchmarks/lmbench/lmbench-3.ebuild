# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/lmbench/lmbench-3.ebuild,v 1.2 2008/05/03 01:13:55 dragonheart Exp $

inherit toolchain-funcs eutils

MY_P=${PN}${PV}
DESCRIPTION="Suite of simple, portable benchmarks"
HOMEPAGE="http://www.bitmover.com/lmbench/whatis_lmbench.html"
SRC_URI="http://www.bitmover.com/lmbench/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.0_alpha3-qa.patch
	sed -e "s#^my \$distro =.*#my \$distro = \"`uname -r`\";#" \
		-e 's#^@files =#chdir "/usr/share/lmbench"; @files =#' \
		-e "s#../../CONFIG#/etc/bc-config#g" "${FILESDIR}"/bc_lm.pl > bc_lm.pl
	sed -i -e "s/^\(bk.ver:\).*/\1/" src/Makefile
	touch src/bk.ver
}

src_compile() {
	emake CC=$(tc-getCC) MAKE=make OS=`scripts/os` build || die
}

src_install() {
	cd src ; make BASE="${D}"/usr install || die

	dodir /usr/share
	mv "${D}"/usr/man "${D}"/usr/share

	cd "${S}"
	exeinto /usr/bin
	doexe "${S}"/bc_lm.pl
	mv "${D}"/usr/bin/stream "${D}"/usr/bin/stream.lmbench

	insinto /etc
	doins "${FILESDIR}"/bc-config

	dodir /usr/share/lmbench
	dodir /usr/share/lmbench/src
	cp src/webpage-lm.tar "${D}"/usr/share/lmbench/src
	cp -R scripts "${D}"/usr/share/lmbench

	dodir /usr/share/lmbench/results
	chmod 777 "${D}"/usr/share/lmbench/results
	dodir /usr/share/lmbench/bin
	chmod 777 "${D}"/usr/share/lmbench/bin

	# avoid file collision with sys-apps/util-linux
	mv "${D}"/usr/bin/line "${D}"/usr/bin/line.lmbench
}
