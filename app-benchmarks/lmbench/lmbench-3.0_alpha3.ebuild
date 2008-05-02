# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/lmbench/lmbench-3.0_alpha3.ebuild,v 1.14 2008/05/02 23:22:07 dragonheart Exp $

inherit toolchain-funcs eutils

MY_P=${P/_alpha/-a}
DESCRIPTION="Suite of simple, portable benchmarks"
HOMEPAGE="http://www.bitmover.com/lmbench/whatis_lmbench.html"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-qa.patch
}

src_compile() {
	sed -e "s#^my \$distro =.*#my \$distro = \"`uname -r`\";#" \
		-e 's#^@files =#chdir "/usr/share/lmbench"; @files =#' \
		-e "s#../../CONFIG#/etc/bc-config#g" ${FILESDIR}/bc_lm.pl > bc_lm.pl

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
	chmod 777 ${D}/usr/share/lmbench/results
	dodir /usr/share/lmbench/bin
	chmod 777 ${D}/usr/share/lmbench/bin

	# avoid file collision with sys-apps/util-linux
	mv ${D}/usr/bin/line ${D}/usr/bin/line.lmbench
}
