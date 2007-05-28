# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-0.90.0.ebuild,v 1.4 2007/05/28 15:40:49 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils python

DOC_PV=0.90.0

DESCRIPTION="Pure python plotting library with matlab like syntax"
HOMEPAGE="http://matplotlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( http://matplotlib.sourceforge.net/users_guide_${DOC_PV}.pdf )"

IUSE="doc examples gtk tk"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="PYTHON"

DEPEND="|| (
		>=dev-python/numpy-1.0
		dev-python/numarray
		>=dev-python/numeric-23
	   )
	!<dev-python/numpy-1.0
	>=media-libs/freetype-2.1.7
	media-libs/libpng
	sys-libs/zlib
	gtk? ( >=dev-python/pygtk-2.2 )
	dev-python/pytz
	dev-python/python-dateutil
	media-fonts/ttf-bitstream-vera"

DOCS="INTERACTIVE API_CHANGES NUMARRAY_ISSUES"

pkg_setup() {
	use tk && python_tkinter_exists
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# disable autodetection (use flags) and install data files
	epatch "${FILESDIR}/${P}-setup.patch"

	# fix default paths for init files (depend on previous patch)
	epatch "${FILESDIR}/${P}-init.patch"

	sed -i \
		-e "/^BUILD_GTK/s/'auto'/$(use gtk && echo 1 || echo 0)/g" \
		-e "/^BUILD_WX/s/'auto'/0/g" \
		-e "/^BUILD_TK/s/'auto'/$(use tk && echo 1 || echo 0)/g" \
		setup.py || die "sed failed"

	# cleaning and remove vera fonts (they are now a dependency)
	chmod 644 images/*.svg
	find -name .cvsignore | xargs rm -rf
	rm -f fonts/ttf/Vera*.ttf

	# default to gtk backend if both gtk and tk are selected
	if use gtk; then
		sed -i \
			-e "s/^#rc\['backend'\] = GTKAgg/rc\['backend'\] = 'GTKAgg'/" \
			setup.py || die "sed backend failed"
	fi
}

src_install() {
	distutils_src_install --install-data=usr/share

	insinto /etc
	doins matplotlibrc

	insinto /usr/share/doc/${PF}
	use doc && doins "${DISTDIR}"/users_guide_${DOC_PV}.pdf
	use examples && doins -r examples
}
