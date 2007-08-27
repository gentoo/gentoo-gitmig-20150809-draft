# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/IceRuby/IceRuby-3.2.1-r1.ebuild,v 1.1 2007/08/27 11:26:53 caleb Exp $

inherit eutils

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="test debug"

RDEPEND="~dev-cpp/Ice-3.2.1
	>=dev-lang/ruby-1.8.4"

DEPEND="${RDEPEND}
	test? ( >=dev-lang/python-2.4 )"

src_unpack() {
#	export ICE_HOME=/usr
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-Makefile.patch
	epatch ${FILESDIR}/${P}-ice_type.patch

	mkdir -p ${S}/bin
	mkdir -p ${S}/lib

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
#	export ICE_HOME=/usr
	make || die "Died during make"
}

src_install() {
#	export ICE_HOME=/usr
	make DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
#	export ICE_HOME=/usr
	make test || die "Test failed"
}
