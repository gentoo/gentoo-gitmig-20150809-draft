# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.7.4.ebuild,v 1.2 2009/04/06 15:20:27 ranger Exp $

EAPI="1"
inherit eutils multilib qt4 fdo-mime python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2
	doc? ( mirror://gentoo/${PN}-0.9.7-manual-en.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="python doc bindist"

LANGS="de es fr ja ru sv"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

CDEPEND=">=x11-libs/qwt-5.1
	>=x11-libs/qwtplot3d-0.2.7
	x11-libs/qt-gui:4
	x11-libs/qt-qt3support:4
	x11-libs/qt-assistant:4
	>=dev-cpp/muParser-1.28
	>=dev-libs/boost-1.35.0
	!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )"

DEPEND="${CDEPEND}
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
	epatch "${FILESDIR}"/${P}-pro.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	epatch "${FILESDIR}"/${P}-liborigin-gcc4.3.patch
	epatch "${FILESDIR}"/${P}-no-python.patch
	epatch "${FILESDIR}"/${P}-sip.patch

	sed -i \
		-e '/manual/d'\
		-e '/3rd/d' \
		qtiplot.pro || die "sed qtiplot.pro failed"

	python_version

	sed -i \
		-e '/manual/d' \
		-e "s:doc/${PN}:doc/${PF}:" \
		-e "s:local/${PN}:$(get_libdir)/python${PYVER}/site-packages:" \
		qtiplot/qtiplot.pro || die " sed for qtiplot/qtiplot.pro failed"

	if ! use python; then
		sed -i \
			-e '/^SCRIPTING_LANGS += Python/d' \
			-e '/sipcmd/d' \
			qtiplot/qtiplot.pro || die "sed for python option failed"
	fi

	# the lib$$suff did not work in the fitRational*.pro files
	pushd fitPlugins >& /dev/null
	sed -i \
		-e "s|/usr/lib\$\${libsuff}|/usr/$(get_libdir)|g" \
		fit*/fitRational*.pro exp_saturation/*.pro explin/*.pro \
		|| die "sed fitRational* failed"
	popd

	for l in ${LANGS}; do
		if ! use linguas_${l}; then
			sed -i \
				-e "s:translations/qtiplot_${l}.ts::" \
				-e "s:translations/qtiplot_${l}.qm::" \
				qtiplot/qtiplot.pro || die
		fi
	done
}

src_compile() {
	eqmake4
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'
	rm -f "${D}"/usr/share/${PN}/translations/*.ts
	use python && chmod -x "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/qti_wordlist.txt

	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot QtiPlot qtiplot

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r "${WORKDIR}"/qtiplot-manual/* \
			|| die "install manual failed"
		rm -rf "${D}"/usr/share/doc/${PF}/html/*/.svn
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	if use python; then
		python_version
		python_mod_compile \
			/usr/$(get_libdir)/python${PYVER}/site-packages/qti{plotrc,Util}.py
	fi

	if use doc; then
		elog "On the first start, do Help -> Choose Help Folder"
		elog "and select /usr/share/doc/${PF}/html"
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update

	if use python; then
		python_version
		python_mod_cleanup
	fi
}
