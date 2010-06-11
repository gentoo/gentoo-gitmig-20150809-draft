# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/IcePy/IcePy-3.2.1.ebuild,v 1.8 2010/06/11 22:50:24 arfrever Exp $

EAPI="2"

inherit eutils python multilib

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test debug"

DEPEND="~dev-libs/Ice-3.2.1"

src_prepare() {
	# Store the PYTHON_VERSION in a variable so the Makefile knows which one to use
	PYTHON_VERSION="$(PYTHON)"

	MAKE_RULES="${S}/config/Make.rules"
	epatch "${FILESDIR}/icepy-${PV}-makefile.patch"
	epatch "${FILESDIR}/IcePy-${PV}-python-2.6.diff"

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" "${MAKE_RULES}" || die "Failed to set lib64 directory"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" "${MAKE_RULES}" || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	"${MAKE_RULES}.Linux" || die "CXXFLAGS patching failed!"

	sed -i -e "s:/lib:/$(get_libdir):g" "${MAKE_RULES}" || die "multilib patch failed"
}

src_compile() {
	emake || die "Died during make"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	ICE_HOME=/usr/share/Ice emake test || die "Test failed"
}
