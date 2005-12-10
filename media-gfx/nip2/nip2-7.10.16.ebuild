# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nip2/nip2-7.10.16.ebuild,v 1.1 2005/12/10 20:35:06 vanquirius Exp $

DESCRIPTION="VIPS Image Processing Graphical User Interface"
SRC_URI="http://www.vips.ecs.soton.ac.uk/vips-7.10/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"

IUSE="fftw"

RDEPEND=">=media-libs/vips-7.10.17
	>=x11-libs/gtk+-2.4
	dev-libs/libxml2
	>=dev-libs/glib-2
	fftw? ( sci-libs/fftw )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_compile() {
	econf \
	$(use_with fftw) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README*
}
