# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glmix/glmix-0.1.ebuild,v 1.3 2004/09/03 00:58:36 dholm Exp $

DESCRIPTION="A 3D widget for mixing up to eight JACK audio streams down to stereo"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

S="${WORKDIR}/glmix"

RDEPEND="virtual/libc
	virtual/jack
	>=x11-libs/gtkglext-1.0.0
	>=x11-libs/gtk+-2.0.0"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin glmix || die "dobin failed"
	dodoc README TODO
}
