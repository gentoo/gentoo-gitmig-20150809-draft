# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlsec/xmlsec-1.2.5.ebuild,v 1.4 2004/10/18 12:30:23 dholm Exp $

inherit eutils

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
	ssl? ( >=dev-libs/openssl-0.9.6c )
	gnutls? ( >=net-libs/gnutls-0.8.1 )
	mozilla? ( >=dev-libs/nspr-4.0
		>=dev-libs/nss-3.2 )"

S=${WORKDIR}/${PN}1-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.2-nss-nspr-configure.in.patch
}

src_compile() {
	autoconf

	local myconf

	if use ssl && [ "`best_version openssl | awk -F- '{print $3}' | sed 's/[a-z]//'`" == "0.9.7" ]; then
		myconf="--enable-aes"
	else
		myconf="--disable-aes"
	fi

	myconf="$myconf --enable-xkms --disable-pkgconfig --enable-gnutls `use_with mozilla nss` `use_with mozilla nspr` \
		`use_enable ssl openssl` --with-html-dir=${D}/usr/share/doc/${PF}"

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}
src_install() {
	einstall || die "install failed"
	dodoc AUTHORS INSTALL README NEWS
}
