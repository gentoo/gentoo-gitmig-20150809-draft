# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlsec/xmlsec-1.2.12.ebuild,v 1.1 2009/07/29 16:37:41 arfrever Exp $

EAPI="2"

inherit autotools eutils flag-o-matic

DESCRIPTION="Command line tool for signing, verifying, encrypting and decrypting XML"
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
	>=dev-libs/libxml2-2.6.12
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}1-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-min_hmac_size.patch"
	epatch "${FILESDIR}/${P}-fix_implicit_declaration.patch"

	sed -i \
		-e '/^XMLSEC_SHLIBSFX=/s/\(XMLSEC_SHLIBSFX=\).*/\1".so"/' \
		-e '/sha1.*pkgconfig/s/sha1/pkgconfig/' \
		-e '/^AC_LIB_LTDL$/d' configure.in || die "sed configure.in failed"
	eautoreconf
}

src_configure() {
	append-cppflags '-DLTDL_OBJDIR=\".libs\"' '-DLTDL_SHLIB_EXT=\".so\"'
	local myconf
	use gnutls || myconf="--without-gnutls"
	econf \
		--enable-pkgconfig \
		--enable-xkms \
		$(use_enable ssl aes) \
		$(use_with ssl openssl /usr) \
		--with-html-dir=/usr/share/doc/${PF} \
		${myconf}
}

src_test() {
	TMPFOLDER="${T}" emake check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README NEWS
}
