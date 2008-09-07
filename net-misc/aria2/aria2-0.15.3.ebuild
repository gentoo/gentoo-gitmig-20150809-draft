# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria2/aria2-0.15.3.ebuild,v 1.1 2008/09/07 10:06:51 dev-zero Exp $

MY_P="aria2c-${PV/_p/+}"

DESCRIPTION="A download utility with resuming and segmented downloading with HTTP/HTTPS/FTP/BitTorrent support."
HOMEPAGE="http://aria2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="ares bittorrent expat gnutls metalink nls ssl test"

CDEPEND="sys-libs/zlib
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.9 )
		!gnutls? ( dev-libs/openssl ) )
	ares? ( >=net-dns/c-ares-1.3.1 )
	bittorrent? ( gnutls? ( >=dev-libs/libgcrypt-1.2.0 ) )
	metalink? (
		!expat? ( >=dev-libs/libxml2-2.6.26 )
		expat? ( dev-libs/expat )
	)"
DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )
	test? ( >=dev-util/cppunit-1.12.0 )"
RDEPEND="${CDEPEND}
	nls? ( virtual/libiconv virtual/libintl )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s|/tmp|${T}|" test/*.cc || die "sed failed"
}

src_compile() {
	use ssl && \
		myconf="${myconf} $(use_with gnutls) $(use_with !gnutls openssl)"

	# Note:
	# - we don't have ares, only libcares
	# - depends on libgcrypt only when using openssl
	# - links only against libxml2 and libexpat when metalink is enabled
	# - always enable gzip/http compression since zlib should always be anyway
	# - always enable epoll since we can assume kernel 2.6.x
	# - other options for threads: solaris, pth, win32
	econf \
		--enable-epoll \
		--enable-threads=posix \
		--with-libz \
		$(use_enable nls) \
		$(use_enable metalink) \
		$(use_with expat libexpat) \
		$(use_with !expat libxml2) \
		$(use_enable bittorrent) \
		--without-ares \
		$(use_with ares libcares) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}/usr/share/doc/aria2c"
	dodoc ChangeLog README AUTHORS TODO NEWS
	dohtml README.html doc/aria2c.1.html
}
