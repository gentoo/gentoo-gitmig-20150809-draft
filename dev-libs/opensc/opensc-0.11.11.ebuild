# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.11.ebuild,v 1.4 2009/12/08 19:22:30 nixnut Exp $

EAPI="2"

inherit multilib

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ppc ~ppc64 ~s390 ~sh ~sparc x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc nsplugin openct pcsc-lite"

RDEPEND="dev-libs/openssl
	sys-libs/zlib
	nsplugin? (
		app-crypt/pinentry
		x11-libs/libXt
	)
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nsplugin? ( dev-libs/libassuan )"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable doc) \
		$(use_enable nsplugin) \
		$(use_enable openct) \
		$(use_enable pcsc-lite pcsc) \
		--with-pinentry="/usr/bin/pinentry" \
		--with-plugindir="/usr/$(get_libdir)/nsbrowser/plugins"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
