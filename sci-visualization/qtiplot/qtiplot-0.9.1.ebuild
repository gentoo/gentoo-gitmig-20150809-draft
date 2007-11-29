# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.1.ebuild,v 1.2 2007/11/29 23:13:41 mr_bones_ Exp $

NEED_PYTHON=2.5

inherit eutils multilib qt4 python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="http://soft.proindependent.com/src/${P}.tar.bz2
	doc? ( http://soft.proindependent.com/doc/manual-en.tar.bz2
		linguas_es? ( http://soft.proindependent.com/doc/manual-es.zip ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python doc"

LANGUAGES="de es fr ja ru sv"
for l in ${LANGUAGES}; do
	IUSE="${IUSE} linguas_${l}"
done

RDEPEND=">=x11-libs/qwt-5.0.2
	>=x11-libs/qwtplot3d-0.2.7
	>=dev-cpp/muParser-1.28
	>=sci-libs/liborigin-20071119
	>=sci-libs/gsl-1.10
	python? ( dev-python/PyQt4
		dev-python/pygsl
		sci-libs/scipy )"

DEPEND="${RDEPEND}
	python? ( >=dev-python/sip-4.5.2 )
	doc? ( linguas_es? ( app-arch/unzip ) )"

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
		fit*/fitRational*.pro
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
		use linguas_es && doins -r "${WORKDIR}"/manual-es
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
		"${ROOT}" /usr/$(get_libdir)/python${PYVER}/site-packages/qtiUtil
}

pkg_postrm() {
	use python && python_mod_cleanup \
		"${ROOT}" /usr/$(get_libdir)/python${PYVER}/site-packages/qtiUtil
}
