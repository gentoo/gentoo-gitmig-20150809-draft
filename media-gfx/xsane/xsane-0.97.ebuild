# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xsane/xsane-0.97.ebuild,v 1.11 2005/09/13 17:49:14 agriffis Exp $

DESCRIPTION="graphical scanning frontend"
HOMEPAGE="http://www.xsane.org/"
SRC_URI="http://www.xsane.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="gtk2 nls jpeg png tiff gimp"

DEPEND="media-gfx/sane-backends
	gtk2? ( >=x11-libs/gtk+-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	gimp? ( media-gfx/gimp )"

pkg_setup() {
	export OLDXSANE
	if has_version '<=media-gfx/xsane-0.93'; then
		OLDXSANE="yes"
	else
		OLDXSANE="no"
	fi
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable gtk2) \
		$(use_enable gimp) \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc xsane.[A-Z]*
	dohtml -r doc

	# link xsane so it is seen as a plugin in gimp
	if use gimp; then
		local plugindir
		if [ -x /usr/bin/gimptool ]; then
			plugindir="$(gimptool --gimpplugindir)/plug-ins"
		elif [ -x /usr/bin/gimptool-2.0 ]; then
			plugindir="$(gimptool-2.0 --gimpplugindir)/plug-ins"
		else
			die "Can't find GIMP plugin directory."
		fi
		dodir "${plugindir}"
		dosym /usr/bin/xsane "${plugindir}"
	fi
}

pkg_postinst() {
	if [ $OLDXSANE = 'yes' ]; then
		einfo ""
		ewarn "If you are upgrading from <=xsane-0.93, please make sure to"
		ewarn "remove ~/.sane/xsane/xsane.rc _before_ you start xsane for"
		ewarn "the first time."
		einfo ""
	fi
}
