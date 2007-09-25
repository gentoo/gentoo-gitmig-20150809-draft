# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/IceRuby/IceRuby-3.2.1-r1.ebuild,v 1.3 2007/09/25 18:53:44 caleb Exp $

inherit eutils

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${P}.tar.gz
	test? ( http://www.zeroc.com/download/Ice/3.2/${P/Ruby/}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="test debug"

RDEPEND="~dev-cpp/Ice-3.2.1
	>=dev-lang/ruby-1.8.4"

DEPEND="${RDEPEND}
	test? ( >=dev-lang/python-2.4 )"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"

	epatch "${FILESDIR}/${P}-Makefile.patch"
	epatch "${FILESDIR}/${P}-ice_type.patch"

	MAKE_RULES="${S}/config/Make.rules"

	mkdir -p "${S}/bin"
	mkdir -p "${S}/lib"

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" "${MAKE_RULES}" \
		|| die "Failed to set lib64 directory"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" \
		"${MAKE_RULES}" || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	"${MAKE_RULES}.Linux" || die "CXXFLAGS patching failed!"
}

src_compile() {
	cd "${S}"
	emake || die "Died during make"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	ICEFILE="${P/Ruby/}.tar.gz"
	ICEWORKDIR="${WORKDIR}/${P/Ruby/}"

	# Unpack Ice
	cd "${WORKDIR}"
	unpack "${ICEFILE}"

	# Patch Ice so we only build the necessary parts
	cd "${ICEWORKDIR}"
	epatch ${FILESDIR}/testing-Makefile.patch

	# Build Ice core libraries
	cd "${ICEWORKDIR}/src"
	emake || die "Ice test build failed"

	# Build the testing binaries
	cd "${ICEWORKDIR}/test"
	emake || die "Ice test build died"

	# Run IceRuby's actual tests
	cd "${S}"
	ICE_HOME=${ICEWORKDIR} emake test || die "Ruby test failed"
}
