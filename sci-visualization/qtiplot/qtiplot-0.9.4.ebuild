# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.4.ebuild,v 1.2 2008/04/29 14:55:52 bicatali Exp $

inherit eutils multilib qt4

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="http://soft.proindependent.com/src/${P}.tar.bz2
	doc? ( mirror://gentoo/${P}-manual-en.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="python doc bindist"

LANGS="de es fr ja ru sv"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

CDEPEND=">=x11-libs/qwt-5.0.2
	>=x11-libs/qwtplot3d-0.2.7
	>=dev-cpp/muParser-1.28
	>=sci-libs/liborigin-20080225
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-systemlibs.patch

	# docs: remove default doc building
	sed -i -e '/manual/d' qtiplot.pro qtiplot/qtiplot.pro \
		|| die "sed for docs failed"
	sed -i -e "s:doc/${PN}:doc/${PF}:" qtiplot/qtiplot.pro

	if ! use python; then
		sed -i \
			-e '/^SCRIPTING_LANGS += Python/d' \
			-e '/sipcmd/d' \
			${PN}/${PN}.pro || die "sed for python option failed"
	fi

	# the lib$$suff did not work in the fitRational*.pro files
	sed -i \
		-e "s|/usr/lib\$\${libsuff}|/usr/$(get_libdir)|g" \
		fitPlugins/fit*/fitRational*.pro \
		|| die "sed fitRational* failed"

	for l in ${LANGS}; do
		if ! use linguas_${l}; then
			sed -i \
				-e "s:translations/qtiplot_${l}.ts::" \
				${PN}/${PN}.pro || die
		fi
	done
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'

	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot QtiPlot qtiplot
	doman qtiplot.1 || die "doman failed"

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r "${WORKDIR}"/qtiplot-manual-en \
			|| die "install manual failed"
	fi

	if use python; then
		cd "${S}"/${PN}
		insinto /etc
		doins qtiplotrc.py qtiUtil.py || die
	fi
}
