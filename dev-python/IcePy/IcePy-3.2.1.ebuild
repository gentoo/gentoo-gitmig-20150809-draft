# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/IcePy/IcePy-3.2.1.ebuild,v 1.1 2007/08/15 16:48:24 caleb Exp $

inherit eutils python

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test debug"

DEPEND="~dev-cpp/Ice-3.2.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/icepy-${PV}-makefile.patch

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" ${S}/config/Make.rules \
		|| die "Failed to set lib64 directory"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" \
		${S}/config/Make.rules || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	${S}/config/Make.rules.Linux || die "CXXFLAGS patching failed!"
}

src_compile() {
	cd ${S}
	make || die "Died during make"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	ICE_HOME=/usr/share/Ice make test || die "Test failed"
}
