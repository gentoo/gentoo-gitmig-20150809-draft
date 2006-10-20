# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nitrogen/nitrogen-1.0_rc4.ebuild,v 1.1 2006/10/20 04:14:02 omp Exp $

MY_P=${P/_rc/-rc}

DESCRIPTION="GTK+ background browser and setter for X."
HOMEPAGE="http://www.minuslab.net/code/nitrogen/"
SRC_URI="http://www.minuslab.net/code/${PN}/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

RDEPEND=">=dev-cpp/gtkmm-2.8
	>=x11-libs/gtk+-2.10
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	xinerama? ( x11-proto/xineramaproto )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_enable xinerama) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
