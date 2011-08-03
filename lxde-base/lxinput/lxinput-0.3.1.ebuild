# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxinput/lxinput-0.3.1.ebuild,v 1.1 2011/08/03 09:26:36 hwoarang Exp $

EAPI="1"

DESCRIPTION="LXDE keyboard and mouse configuration tool"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.40.0"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README || die 'dodoc failed'
}
