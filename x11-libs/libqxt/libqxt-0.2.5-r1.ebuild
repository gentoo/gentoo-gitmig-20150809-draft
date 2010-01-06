# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libqxt/libqxt-0.2.5-r1.ebuild,v 1.4 2010/01/06 13:03:49 hwoarang Exp $

EAPI="2"
inherit eutils qt4-r2

DESCRIPTION="The Qt eXTension library provides cross-platform utility classes for the Qt toolkit"
HOMEPAGE="http://libqxt.org/"
SRC_URI="mirror://sourceforge/libqxt/${P}.tar.gz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="ssl fastcgi debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-script:4
	x11-libs/qt-sql:4
	ssl? ( >=dev-libs/openssl-0.9.8 )
	fastcgi? ( >=dev-libs/fcgi-2.4 )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf

	use debug && myconf="${myconf} -debug"
	use !ssl && myconf="${myconf} -nomake crypto"
	use !fastcgi && myconf="${myconf} -nomake web"
	# fix pre-stripped files issue
	for i in $(ls "${S}"/src); do
		sed -i "s/qxtbuild/nostrip\ qxtbuild/" "${S}"/src/${i}/${i}.pro
	done
	./configure -prefix /usr ${myconf}
}

src_compile() {
	# fails with parallel build, bug 194730
	emake -j1 || die "emake failed"
}
