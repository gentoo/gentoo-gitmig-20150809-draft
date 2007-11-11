# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlsec/xmlsec-1.2.11.ebuild,v 1.2 2007/11/11 06:28:50 mr_bones_ Exp $

DESCRIPTION="command line tool for signing, verifying, encrypting and decrypting XML"
HOMEPAGE="http://www.aleksey.com/xmlsec"
SRC_URI="http://www.aleksey.com/xmlsec/download/${PN}1-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="ssl mozilla gnutls"

DEPEND=">=sys-devel/autoconf-2.2
	>=dev-libs/libxml2-2.4.2
	>=dev-libs/libxslt-1.0.20
	dev-util/pkgconfig
	ssl? ( >=dev-libs/openssl-0.9.7 )
	gnutls? ( >=net-libs/gnutls-0.8.1 dev-libs/libgcrypt )
	mozilla? ( >=dev-libs/nspr-4.0
		>=dev-libs/nss-3.2 )"

S="${WORKDIR}/${PN}1-${PV}"

src_compile() {
	econf --enable-xkms \
		$(use_enable ssl openssl) \
		$(use_enable ssl aes) \
		--with-html-dir=/usr/share/doc/${PF} \
		|| die "configure failed"
	emake || die "emake failed"
}

src_test() {
	TMPFOLDER="${T}" make check || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README NEWS
}
