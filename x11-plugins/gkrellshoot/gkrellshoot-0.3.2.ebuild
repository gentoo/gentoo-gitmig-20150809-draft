# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.3.2.ebuild,v 1.6 2005/01/02 01:59:22 mholzer Exp $

IUSE=""
S=${WORKDIR}/${P/s/S}
DESCRIPTION="A GKrellM plugin to snap screenshots."
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"
HOMEPAGE="http://gkrellshoot.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

# It uses "import" which comes with imagemagick to snap the screenshots
RDEPEND="media-gfx/imagemagick"

src_compile() {
	export CFLAGS="${CFLAGS/-O?/}"
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellshoot.so
	dodoc ChangeLog README
}
