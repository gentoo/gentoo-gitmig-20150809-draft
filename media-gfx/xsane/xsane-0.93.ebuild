# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.93.ebuild,v 1.4 2004/07/31 02:57:52 tgall Exp $

DESCRIPTION="graphical scanning frontend"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"
HOMEPAGE="http://www.xsane.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc amd64 ~sparc ppc64"
IUSE="gtk2 nls jpeg png tiff"

DEPEND="media-gfx/sane-backends
	|| (
		gtk2? ( >=x11-libs/gtk+-2.0 )
		=x11-libs/gtk+-1.2*
	)
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"


src_compile() {
	econf \
		`use_enable nls` \
		`use_enable jpeg` \
		`use_enable png` \
		`use_enable tiff` \
		`use_enable gtk2` \
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
