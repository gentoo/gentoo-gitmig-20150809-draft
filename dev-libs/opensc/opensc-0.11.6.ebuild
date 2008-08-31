# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.6.ebuild,v 1.3 2008/08/31 13:04:23 ranger Exp $

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ppc ppc64 ~s390 ~sh ~sparc x86"

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
		--with-plugin-dir=/usr/lib/mozilla/plugins \
		--with-pin-entry="/usr/bin/pinentry" \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
