# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-xfce/gtk-engines-xfce-2.2.8.ebuild,v 1.4 2006/09/05 21:58:40 gustavoz Exp $

MY_P="gtk-xfce-engine-${PV}"

S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+2 Xfce Theme Engine"
HOMEPAGE="http://xfce.sourceforge.net/"
SRC_URI="http://www.xfce.org/archive/xfce-4.2.3.2/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 mips ~ppc ~ppc64 sparc ~x86"
IUSE="static"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Instalation failed"

	dodoc AUTHORS ChangeLog NEWS README
}
