# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-view-open-client/vmware-view-open-client-4.5.0.297975.ebuild,v 1.1 2011/02/19 17:53:48 tgurr Exp $

EAPI="2"

inherit versionator

MY_PV=$(replace_version_separator 3 '-' )
MY_P="${PN/vm/VM}-source-${MY_PV}"

DESCRIPTION="Open Source VMware View Client"
HOMEPAGE="http://code.google.com/p/vmware-view-open-client/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/boost-1.34.1
	>=dev-libs/icu-3.8.0
	>=dev-libs/libxml2-2.6.0
	>=dev-libs/openssl-0.9.8
	>=net-misc/curl-7.16.0[ssl]
	>=x11-libs/gtk+-2.4.0"

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.21
	>=dev-util/pkgconfig-0.9.0"

RDEPEND="${COMMON_DEPEND}
	>=net-misc/rdesktop-1.4.1"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--disable-static-icu \
		--enable-nls \
		--with-boost
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
