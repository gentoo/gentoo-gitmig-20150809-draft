# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glmix/glmix-0.1.ebuild,v 1.1 2004/08/22 21:47:21 fvdpol Exp $

IUSE=""

DESCRIPTION="A 3D widget for mixing up to eight JACK audio streams down to stereo"
HOMEPAGE="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/"
SRC_URI="http://www.ecs.soton.ac.uk/~njl98r/code/ladspa/${P}.tar.gz"
RESTRICT=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#first two for WANT_AUTOMAKE/CONF
DEPEND=">=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2
	>=dev-util/pkgconfig-0.12.0
	virtual/glibc
	virtual/jack
	>=x11-libs/gtkglext-1.0.0
	>=x11-libs/gtk+-2.0.0"

src_compile() {
	cd ${WORKDIR}/glmix && \
	emake || die
}

src_install() {
	cd ${WORKDIR}/glmix && \
	dobin glmix
	dodoc COPYING README TODO
}
