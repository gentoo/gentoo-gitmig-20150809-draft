# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcre++/pcre++-0.9.5-r1.ebuild,v 1.11 2007/11/03 10:40:52 swegener Exp $

inherit eutils autotools

DESCRIPTION="A C++ support library for libpcre"
HOMEPAGE="http://www.daemon.de/PCRE"
SRC_URI="ftp://ftp.daemon.de/scip/Apps/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-libs/libpcre"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/${P}-patches" \
	EPATCH_FORCE="yes" \
	epatch

	./autogen.sh || die "autogen.sh failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	dohtml -r doc/html/.
	doman doc/man/man3/Pcre.3

	rm -rf "${D}"/usr/doc
}
