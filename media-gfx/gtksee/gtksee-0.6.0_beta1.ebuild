# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtksee/gtksee-0.6.0_beta1.ebuild,v 1.2 2004/11/15 20:10:02 mr_bones_ Exp $

DESCRIPTION="A simple but functional image viewer/browser - ACD See alike."
HOMEPAGE="http://gtksee.berlios.de/"
SRC_URI="http://download.berlios.de/gtksee/${P/_beta1/b-1}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	>=media-libs/libpng-1.2.1
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_beta1/b-1}"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	# broken makefiles that don't support DESTDIR with USE nls (bug #65889)
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
