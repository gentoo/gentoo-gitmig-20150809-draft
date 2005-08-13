# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.97.ebuild,v 1.7 2005/08/13 23:13:26 hansmi Exp $

DESCRIPTION="graphical scanning frontend"
HOMEPAGE="http://www.xsane.org/"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="gtk2 nls jpeg png tiff"

DEPEND="media-gfx/sane-backends
	gtk2? ( >=x11-libs/gtk+-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"


src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable gtk2) \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc xsane.[A-Z]*
	dohtml -r doc

	# link xsane so it is seen as a plugin in gimp
	if [ -d /usr/lib/gimp/1.2 ]; then
		dodir /usr/lib/gimp/1.2/plug-ins
		dosym /usr/bin/xsane /usr/lib/gimp/1.2/plug-ins
	fi
	if [ -d /usr/lib/gimp/2.0 ]; then
		dodir /usr/lib/gimp/2.0/plug-ins
		dosym /usr/bin/xsane /usr/lib/gimp/2.0/plug-ins
	fi
}

pkg_postinst() {
	einfo ""
	ewarn "If you are upgrading from <=xsane-0.93, please make sure to"
	ewarn "remove ~/.sane/xsane/xsane.rc _before_ you start xsane for"
	ewarn "the first time."
	einfo ""
}
