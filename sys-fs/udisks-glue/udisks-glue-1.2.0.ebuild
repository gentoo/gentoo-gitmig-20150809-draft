# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks-glue/udisks-glue-1.2.0.ebuild,v 1.2 2011/01/03 18:24:50 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="A tool to associate udisks events to user-defined actions"
HOMEPAGE="http://github.com/fernandotcl/udisks-glue"
SRC_URI="https://github.com/fernandotcl/udisks-glue/tarball/release-1.2.0 -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/confuse"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README
}
