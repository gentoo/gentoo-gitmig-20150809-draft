# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/gperf/gperf-2.7.2.ebuild,v 1.1 2002/04/04 03:57:13 chadh Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GNU performance analyzer"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gperf/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gperf/gperf.html"
DEPEND=""

src_install () {
	make DESTDIR=${D} install || die
}
