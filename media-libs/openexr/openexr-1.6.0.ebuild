# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.6.0.ebuild,v 1.5 2007/09/23 16:21:04 armin76 Exp $

DESCRIPTION="ILM's OpenEXR high dynamic-range image file format libraries"
HOMEPAGE="http://openexr.com/"
SRC_URI="http://download.savannah.nongnu.org/releases/openexr/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND="media-libs/ilmbase"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Replace the temporary directory used for tests.
	sed -i -e 's:"/var/tmp/":"'${T}'":' "IlmImfTest/tmpDir.h"
}

src_compile() {
	econf $(use_enable examples imfexamples)
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" examplesdir="/usr/share/doc/${PF}/examples" install || \
		die "install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		insinto "/usr/share/doc/${PF}"
		doins doc/*.pdf
	fi
	rm -frv "${D}usr/share/doc/OpenEXR"*

	if use examples ; then
		dobin "IlmImfExamples/imfexamples"
	else
		rm -fr "${D}usr/share/doc/${PF}/examples"
	fi
}

pkg_postinst() {
	einfo "OpenEXR was divided into IlmBase, OpenEXR, and OpenEXR_Viewers."
	einfo "Viewers are available in OpenEXR_Viewers package."
	einfo "If you want them, run:"
	einfo
	einfo "emerge media-gfx/openexr_viewers"
	einfo

	ewarn "OpenEXR may have had ABI changes."
	ewarn "Please run revdep-rebuild"
	ewarn "to rebuild programs using it"
	ewarn "(like KDELibs, KRita, ImageMagick, etc.)."
}
