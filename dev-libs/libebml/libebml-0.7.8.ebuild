# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libebml/libebml-0.7.8.ebuild,v 1.1 2008/03/13 00:07:43 beandog Exp $

DESCRIPTION="Extensible binary format library (kinda like XML)"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_install() {
	cd "${S}"/make/linux
	einstall libdir="${D}/usr/$(get_libdir)" || die "make install failed"
	dodoc "${S}"/ChangeLog
}
