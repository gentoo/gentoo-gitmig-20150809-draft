# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gperf/gperf-2.7.2.ebuild,v 1.14 2004/05/05 08:12:53 dragonheart Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A perfect hash function generator."
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gperf/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gperf/gperf.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64 hppa ia64"

RDEPEND="virtual/glibc
	>=sys-apps/sed"

DEPEND="virtual/glibc"

src_compile() {
	sed -i -e "s#^docdir = \$(prefix).*#docdir = @datadir@/doc/${PF}#" doc/Makefile.in
	econf || die "died during configuration"
	emake || die "died during make"
}

src_install () {
	make DESTDIR=${D} install || die
}
