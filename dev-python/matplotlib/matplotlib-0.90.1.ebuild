# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-0.90.1.ebuild,v 1.3 2007/08/18 18:32:14 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils

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
	dev-python/python-dateutil"

RDEPEND="${DEPEND}
	app-text/dvipng
	media-fonts/ttf-bitstream-vera"



DOCS="INTERACTIVE API_CHANGES NUMARRAY_ISSUES"

pkg_setup() {
	use tk && distutils_python_tkinter
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# disable autodetection (use flags) and install data files
	epatch "${FILESDIR}/${P}-setup.patch"
	sed -i \
		-e "/^BUILD_GTK/s/'auto'/$(use gtk && echo 1 || echo 0)/g" \
		-e "/^BUILD_WX/s/'auto'/0/g" \
		-e "/^BUILD_TK/s/'auto'/$(use tk && echo 1 || echo 0)/g" \
		setup.py || die "sed autodetection failed"

	# default matplotlibrc in /etc
	sed -i \
		-e '/mpl-data\/matplotlibrc/d' \
		setup.py || die "sed matplotlibrc failed"
	sed -i \
		-e "s:path =  get_data_path():path = '/etc':" \
		lib/matplotlib/__init__.py || die "sed init failed"

	# cleaning and remove vera fonts (they are now a dependency)
	find -name .cvsignore -exec rm -rf {} \;
	rm -f lib/matplotlib/mpl-data/fonts/ttf/Vera*.ttf

}

src_install() {
	distutils_src_install

	# default to gtk backend if both gtk and tk are selected
	if use gtk && use tk; then
		sed -i \
			-e '/^backend/s/TkAgg/GTKAgg/' \
			lib/matplotlib/mpl-data/matplotlibrc || die "sed backend failed"
	fi
	insinto /etc
	doins lib/matplotlib/mpl-data/matplotlibrc || die "installing matplotlibrc failed"

	insinto /usr/share/doc/${PF}
	use doc && doins "${DISTDIR}"/users_guide_${DOC_PV}.pdf
	use examples && doins -r examples
}
