# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.2.ebuild,v 1.2 2008/01/14 18:20:41 bicatali Exp $

inherit eutils multilib qt4 python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="http://soft.proindependent.com/src/${P}.tar.bz2
	doc? ( mirror://gentoo/${P}-manual-en.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python doc"

LANGUAGES="de es fr ja ru sv"
for l in ${LANGUAGES}; do
	IUSE="${IUSE} linguas_${l}"
done

CDEPEND=">=x11-libs/qwt-5.0.2
	>=x11-libs/qwtplot3d-0.2.7
	>=dev-cpp/muParser-1.28
	>=sci-libs/liborigin-20071119
	>=sci-libs/gsl-1.10"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/sip-4.5.2 )"

RDEPEND="${CDEPEND}
	python? ( >=dev-lang/python-2.5
		dev-python/PyQt4
		dev-python/pygsl
		sci-libs/scipy )"

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-systemlibs.patch

	for l in ${LANGUAGES}; do
		use linguas_${l} || \
			sed -i -e "s:translations/qtiplot_${l}.ts::" ${PN}/${PN}.pro
	done
	use python || sed -i -e 's/^\(SCRIPTING_LANGS += Python\)/#\1/' ${PN}.pro

	# the lib$$suff did not work in the fitRational*.pro files
	sed -i \
		-e "s|/usr/lib\$\${libsuff}|$(get_libdir)|g" \
		fitPlugins/fit*/fitRational*.pro \
		|| die "sed fitRational* failed"
}

src_compile() {
	eqmake4 ${PN}.pro || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'

	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot QtiPlot qtiplot Science
	doman qtiplot.1

	if use doc; then
		insinto "/usr/share/doc/${PF}"
		doins -r "${WORKDIR}"/manual-en
	fi

	for l in ${LANGUAGES}; do
		if use linguas_${l}; then
			insinto /usr/share/${PN}/translations
			doins ${PN}/translations/*${l}*.qm
		fi
	done

	if use python; then
		cd "${S}"/${PN}
		insinto /etc
		doins qtiplotrc.py
		python_version
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/
		doins qtiUtil.py
	fi
}

pkg_postinst() {
	use python && python_mod_optimize \
		"${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/qtiUtil
}

pkg_postrm() {
	use python && python_mod_cleanup \
		"${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/qtiUtil
}
