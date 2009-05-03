# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlsec/xmlsec-1.2.11.ebuild,v 1.4 2009/05/03 18:08:54 arfrever Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="command line tool for signing, verifying, encrypting and decrypting XML"
HOMEPAGE="http://www.aleksey.com/xmlsec"
SRC_URI="http://www.aleksey.com/xmlsec/download/${PN}1-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gnutls mozilla ssl"

RDEPEND=">=dev-libs/libxslt-1.0.20
	ssl? ( >=dev-libs/openssl-0.9.7 )
	gnutls? ( >=net-libs/gnutls-0.8.1 )
	mozilla? ( >=dev-libs/nspr-4.0
		>=dev-libs/nss-3.2 )"
DEPEND="${RDEPEND}
	>=dev-libs/libxml2-2.4.2
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}1-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gnutls.patch"
	eautoreconf
}

src_configure() {
	append-cppflags '-DLTDL_OBJDIR=\".libs\"' '-DLTDL_SHLIB_EXT=\".so\"'
	local myconf
	use gnutls || myconf="--without-gnutls"
	econf \
		--enable-pkgconfig \
		--enable-xkms \
		$(use_enable ssl openssl) \
		$(use_enable ssl aes) \
		--with-html-dir=/usr/share/doc/${PF} \
		${myconf}
}

src_test() {
	TMPFOLDER="${T}" make check || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README NEWS
}
