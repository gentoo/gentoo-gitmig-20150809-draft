# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nodejs/nodejs-0.6.12.ebuild,v 1.1 2012/03/05 06:37:08 patrick Exp $

EAPI="3"

inherit eutils pax-utils

PYTHON_DEPEND="2"
# omgwtf
RESTRICT="test"

DESCRIPTION="Evented IO for V8 Javascript"
HOMEPAGE="http://nodejs.org/"
SRC_URI="http://nodejs.org/dist/v${PV}/node-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE=""

DEPEND=">=dev-lang/v8-3.6.6.24
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/node-v${PV}

src_prepare() {
	sed -i -e "/flags = \['-arch', arch\]/s/= .*$/= ''/" wscript || die
}

src_configure() {
	# this is a waf confuserator
	./configure --shared-v8 --prefix="${EPREFIX}"/usr || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	pax-mark -m "${ED}"/usr/bin/node
}

src_test() {
	emake test || die
}
