# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/gperf/gperf-2.7.2.ebuild,v 1.2 2002/06/21 08:58:45 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A perfect hash function generator."
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gperf/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gperf/gperf.html"
DEPEND=""

SLOT=""
LICENSE="GPL-2"

src_install () {
	make DESTDIR=${D} install || die
}
