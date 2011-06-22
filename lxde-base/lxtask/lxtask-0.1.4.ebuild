# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxtask/lxtask-0.1.4.ebuild,v 1.1 2011/06/22 07:23:29 hwoarang Exp $

EAPI="4"

inherit autotools

DESCRIPTION="LXDE Task manager"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40.0"

src_prepare() {
	# en_GB.po file does not exist and breaks compilation
	sed -i -e "/^ALL_LINGUAS/s:en_GB::" \
		configure.ac || die
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README || die "dodoc failed"
}
