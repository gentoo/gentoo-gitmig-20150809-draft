# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblazy/liblazy-0.1.ebuild,v 1.2 2008/01/19 14:08:22 genstef Exp $

DESCRIPTION="lib for D-Bus daemon messages, querying HAL or PolicyKit privileges"
HOMEPAGE="http://freedesktop.org/wiki/Software_2fliblazy"
SRC_URI="http://people.freedesktop.org/~homac/liblazy/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-apps/dbus-0.62
	dev-util/pkgconfig"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
