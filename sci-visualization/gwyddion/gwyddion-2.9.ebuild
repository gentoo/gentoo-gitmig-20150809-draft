# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/gwyddion/gwyddion-2.9.ebuild,v 1.2 2008/04/21 16:09:51 bicatali Exp $

DESCRIPTION="A software framework for SPM data analysis"
HOMEPAGE="http://gwyddion.net/"
SRC_URI="http://gwyddion.net/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python perl ruby nls"

RDEPEND="virtual/opengl
	python? ( virtual/python )
	perl? ( dev-lang/perl )
	ruby? ( virtual/ruby )
	>=x11-libs/gtk+-2.8
	x11-libs/pango
	x11-libs/cairo
	x11-libs/gtkglext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable python) \
		$(use_enable perl) \
		$(use_enable ruby) \
		$(use_enable nls) \
		--disable-desktop-file-update \
		|| die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
