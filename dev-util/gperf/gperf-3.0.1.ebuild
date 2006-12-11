# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gperf/gperf-3.0.1.ebuild,v 1.18 2006/12/11 07:32:05 beu Exp $

inherit eutils

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="http://www.gnu.org/software/gperf/gperf.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/gperf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_install() {
	make DESTDIR="${D}" install || die
}
