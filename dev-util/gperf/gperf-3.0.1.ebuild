# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gperf/gperf-3.0.1.ebuild,v 1.2 2004/03/08 05:10:35 psi29a Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A perfect hash function generator."
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gperf/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gperf/gperf.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~hppa ~mips"

DEPEND="virtual/glibc"

src_install () {
	make DESTDIR=${D} install || die
}
