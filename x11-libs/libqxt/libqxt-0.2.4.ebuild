# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libqxt/libqxt-0.2.4.ebuild,v 1.3 2007/09/28 18:16:05 caleb Exp $

inherit eutils qt4

DESCRIPTION="The Qt eXTension library provides cross-platform utility classes to add functionality ontop of the Qt toolkit"
HOMEPAGE="http://libqxt.org/"
SRC_URI="mirror://sourceforge/libqxt/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="ssl fastcgi debug"

DEPEND=">=x11-libs/qt-4.2
	ssl? ( >=dev-libs/openssl-0.9.8 )
	fastcgi? ( >=dev-libs/fcgi-2.4 )"
RDEPEND="${DEPEND}"

QT4_BUILT_WITH_USE_CHECK="png ssl"

S="${WORKDIR}/${PN}"

src_compile() {
	local myconf

	use debug && myconf="${myconf} -debug"
	use !ssl && myconf="${myconf} -nomake crypto"
	use !fastcgi && myconf="${myconf} -nomake web"

	./configure -prefix /usr ${myconf}

	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
