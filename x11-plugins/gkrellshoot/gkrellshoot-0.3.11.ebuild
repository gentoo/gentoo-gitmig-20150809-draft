# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.3.11.ebuild,v 1.4 2002/10/04 06:45:33 vapier Exp $

S=${WORKDIR}/gkrellShoot-0.3.11
DESCRIPTION="A GKrellM plugin with two buttons, one to lock another to snap
screenshots."
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"
HOMEPAGE="http://gkrellshoot.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

# It uses "import" which comes with imagemagick to snap the screenshots
RDEPEND="media-gfx/imagemagick"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellshoot.so
	dodoc ChangeLog README
}
