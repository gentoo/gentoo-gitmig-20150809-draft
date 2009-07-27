# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xml-security-c/xml-security-c-1.5.1.ebuild,v 1.2 2009/07/27 09:54:18 dev-zero Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Apache C++ XML security libraries."
HOMEPAGE="http://santuario.apache.org/"
SRC_URI="http://santuario.apache.org/dist/c-library/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples xalan"

RDEPEND="dev-libs/xerces-c
	xalan? ( dev-libs/xalan-c )
	dev-libs/openssl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}/${PV}-parallel_build.patch" \
		"${FILESDIR}/${PV}-xalan-c-1.11-compat.patch"

	# script checks for autoconf for no reason
	sed -i \
		-e '/AUTOCONF/d' configure.ac || die "sed failed"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with xalan)
}

src_install(){
	emake DESTDIR="${D}" install || die "emake failed"

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins src/samples/*.cpp
	fi
}
