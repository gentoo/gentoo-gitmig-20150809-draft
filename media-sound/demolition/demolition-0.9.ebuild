# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/demolition/demolition-0.9.ebuild,v 1.3 2004/09/03 00:33:12 dholm Exp $

DESCRIPTION="A destruction/stress testing tool for LADSPA plugins. It's intended mostly for sanity checking your own code before you release it to the world."
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/demolition.html"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

S=${WORKDIR}/demolition

RDEPEND="virtual/libc
	>=dev-libs/glib-1.2.0
	media-libs/ladspa-sdk"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin demolition || die "dobin failed"
}
