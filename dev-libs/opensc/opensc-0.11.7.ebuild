# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.7.ebuild,v 1.10 2009/04/10 21:51:20 arfrever Exp $

inherit multilib

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ppc ppc64 s390 sh sparc x86"

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

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable openct) \
		$(use_enable pcsc-lite pcsc) \
		$(use_enable nsplugin) \
		$(use_enable doc) \
		--with-pinentry="/usr/bin/pinentry"
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}

pkg_postinst() {
	elog "This package is a security fix to CVE-2009-0368. If you have private keys on your"
	elog "smart card intialised by this package they may be stored with improper access restrictions."
	elog "See advisory http://thread.gmane.org/gmane.comp.encryption.opensc.announce/22 for"
	elog "full details and mitigation advice"
}
