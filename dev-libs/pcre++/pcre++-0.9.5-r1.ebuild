# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcre++/pcre++-0.9.5-r1.ebuild,v 1.13 2008/05/25 06:41:37 corsair Exp $

inherit eutils autotools

DESCRIPTION="A C++ support library for libpcre"
HOMEPAGE="http://www.daemon.de/PCRE"
SRC_URI="http://www.daemon.de/files/mirror/ftp.daemon.de/scip/Apps/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/${P}-patches" \
	EPATCH_FORCE="yes" \
	epatch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	dohtml -r doc/html/.
	doman doc/man/man3/Pcre.3

	rm -rf "${D}/usr/doc"
}
