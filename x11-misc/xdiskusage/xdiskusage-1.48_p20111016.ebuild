# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.48_p20111016.ebuild,v 1.2 2011/10/16 19:58:46 ssuominen Exp $

EAPI=4
inherit autotools

DESCRIPTION="front end to xdu for viewing disk usage graphically under X11"
HOMEPAGE="http://xdiskusage.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/fltk-1.3:1"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() { eautoreconf; }
src_compile() {
	emake \
		CXXFLAGS="${CXXFLAGS} $(fltk-config --cxxflags)" \
		LDLIBS="$(fltk-config --ldflags)"
}
src_install() { dobin ${PN}; doman ${PN}.1; dodoc README; }
