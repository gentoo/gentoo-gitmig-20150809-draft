# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellshoot/gkrellshoot-0.3.11.ebuild,v 1.1 2002/06/11 01:06:01 lamer Exp $

S=${WORKDIR}/gkrellShoot-0.3.11
DESCRIPTION="A GKrellM plugin with two buttons, one to lock another to snap
screenshots."
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"
HOMEPAGE="http://gkrellshoot.sf.net"

DEPEND=">=app-admin/gkrellm-1.2.9
	=x11-libs/gtk+-1.2*
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
