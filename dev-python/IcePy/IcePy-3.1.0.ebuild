# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/IcePy/IcePy-3.1.0.ebuild,v 1.1 2006/09/11 12:35:12 caleb Exp $

inherit eutils python

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="test debug"

DEPEND="=dev-cpp/ice-3.1*"

ICE_HOME=/usr

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/icepy-3.1.0-makefile.patch

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
	export ICE_HOME=/usr
	./configure
	make || die "Died during make"
}

src_install() {
	export ICE_HOME=/usr
	make DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	export ICE_HOME=/usr
	make test || die "Test failed"
}
