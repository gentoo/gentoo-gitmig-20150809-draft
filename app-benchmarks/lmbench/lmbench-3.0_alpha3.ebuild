# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/lmbench/lmbench-3.0_alpha3.ebuild,v 1.2 2004/02/08 03:26:47 dragonheart Exp $

MY_P=${P/_alpha/-a}

DESCRIPTION="Suite of simple, portable benchmarks"

HOMEPAGE="http://www.bitmover.com/lmbench/whatis_lmbench.html"

SRC_URI="ftp://ftp.bitmover.com/lmbench/${MY_P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc"

#RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {

	sed -e "s#^my \$distro =.*#my \$distro = \"`uname -r`\";#" \
		-e 's#^@files =#chdir "/usr/share/lmbench"; @files =#' \
		-e "s#../../CONFIG#/etc/bc-config#g" ${FILESDIR}/bc_lm.pl > bc_lm.pl

	emake CC=${CC} MAKE=make OS=`scripts/os` build || die
}

src_install() {

	cd src ; make BASE=${D}/usr install || die

	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share

	cd ${S}
	exeinto /usr/bin
	doexe ${S}/bc_lm.pl

	insinto /etc
	doins ${FILESDIR}/bc-config

	dodir /usr/share/lmbench
	dodir /usr/share/lmbench/src
	cp src/webpage-lm.tar ${D}/usr/share/lmbench/src
	cp -R scripts ${D}/usr/share/lmbench

	dodir /usr/share/lmbench/results
	chmod 777 ${D}/usr/share/lmbench/results
	dodir /usr/share/lmbench/bin
	chmod 777 ${D}/usr/share/lmbench/bin

}
