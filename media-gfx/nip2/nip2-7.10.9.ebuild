# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nip2/nip2-7.10.9.ebuild,v 1.1 2005/04/06 21:13:07 lu_zero Exp $

DESCRIPTION="VIPS Image Processing Graphical User Interface"
SRC_URI="http://www.vips.ecs.soton.ac.uk/vips-7.10/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"

IUSE="fftw"

RDEPEND=">=media-libs/vips-7.10.7
		>=x11-libs/gtk+-2.4
		dev-libs/libxml2
		>=dev-libs/glib-2
		fftw? ( >=sci-libs/fftw )"

DEPEND="${RDEPEND}
		sys-devel/flex
		sys-devel/bison"


src_compile() {
	local myconf
	use fftw || myconf="--without-fftw"
	econf ${myconf} || die
	emake || die
}


src_install() {
	emake install DESTDIR=${D} || die
}
