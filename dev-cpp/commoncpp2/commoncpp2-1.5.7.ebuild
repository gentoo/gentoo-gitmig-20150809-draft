# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.5.7.ebuild,v 1.5 2007/08/16 09:52:51 dertobi123 Exp $

inherit autotools eutils

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug doc examples ipv6 gnutls"

RDEPEND="gnutls? ( dev-libs/libgcrypt
		net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )
	sys-libs/zlib"
DEPEND="doc? ( >=app-doc/doxygen-1.3.6 )
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-as-needed.patch"
	epatch "${FILESDIR}/${PV}-ssl_config.patch"
	AT_M4DIR="m4"
	eautoreconf
}

src_compile() {
	use doc || \
		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure || die "sed failed"

	local myconf
	use gnutls || myconf="--with-openssl"

	econf \
		$(use_enable debug) \
		$(use_with ipv6 ) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS ChangeLog README THANKS TODO COPYING.addendum

	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		cd demo
		doins *.cpp *.h *.xml README
	fi
}

# Some of the tests hang forever
#src_test() {
#	cd "${S}/tests"
#	emake || die "emake tests failed"
#	./test.sh || die "tests failed"
#}
