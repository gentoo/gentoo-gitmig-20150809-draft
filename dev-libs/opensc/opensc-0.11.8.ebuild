# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.8.ebuild,v 1.3 2009/05/16 15:39:37 jer Exp $

EAPI="2"

inherit multilib

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="alpha ~amd64 ~arm hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="pcsc-lite openct nsplugin doc"

RDEPEND="dev-libs/openssl
	sys-libs/zlib
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )
	nsplugin? (
		app-crypt/pinentry
		x11-libs/libXt
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nsplugin? ( dev-libs/libassuan )"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable openct) \
		$(use_enable pcsc-lite pcsc) \
		$(use_enable nsplugin) \
		$(use_enable doc) \
		--with-pinentry="/usr/bin/pinentry"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "This package contains security fix for CVE-2009-1603. pkcs11-tool from OpenSC 0.11.7,"
	elog "when used with third-party PKCS#11 modules, generated RSA keys with incorrect public"
	elog "exponents, which allows attackers to read the cleartext form of messages that were"
	elog "intended to be encrypted."
	elog "See http://www.opensc-project.org/pipermail/opensc-announce/2009-May/000025.html"
	elog "for details"
}
