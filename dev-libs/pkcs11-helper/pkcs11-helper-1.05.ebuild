# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pkcs11-helper/pkcs11-helper-1.05.ebuild,v 1.2 2007/10/22 14:29:51 alonbl Exp $

DESCRIPTION="PKCS#11 helper library"
HOMEPAGE="http://www.opensc-project.org/pkcs11-helper"
SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnutls nss"

RDEPEND=">=dev-libs/openssl-0.9.7"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=app-doc/doxygen-1.4.7 )
	gnutls? ( >=net-libs/gnutls-1.4.4 )
	nss? ( dev-libs/nss )"

RESTRICT="test"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable doc) \
		$(use_enable gnutls crypto-engine-gnutls) \
		$(use_enable nss crypto-engine-nss) \
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	mv "${D}/usr/share/doc/${PF}/api" "${T}"
	prepalldocs
	mv "${T}/api" "${D}/usr/share/doc/${PF}"
}
