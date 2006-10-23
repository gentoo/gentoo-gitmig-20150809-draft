# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.5.1-r1.ebuild,v 1.3 2006/10/23 16:24:51 dev-zero Exp $

inherit autotools eutils

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
SRC_URI="mirror://sourceforge/gnutelephony/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
	epatch "${FILESDIR}/ccext2-as-needed.diff"
	epatch "${FILESDIR}/${PV}-ssl_config.patch"
	eautoconf
}

src_compile() {
	use doc || \
		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure || die "sed failed"

	local myconf
	if use gnutls ; then
		myconf="--with-gnutls"
	else
		myconf="--with-openssl"
	fi
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
