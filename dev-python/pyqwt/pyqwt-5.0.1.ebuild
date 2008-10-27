# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyqwt/pyqwt-5.0.1.ebuild,v 1.6 2008/10/27 10:50:09 hawking Exp $

EAPI="1"
inherit eutils python toolchain-funcs

MY_P="PyQwt-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Python bindings for the Qwt library"
SRC_URI="mirror://sourceforge/pyqwt/${MY_P}.tar.gz"
HOMEPAGE="http://pyqwt.sourceforge.net/"
SLOT="5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="debug doc examples"

RDEPEND="virtual/python
	x11-libs/qwt:5
	>=dev-python/PyQt4-4.2
	>=dev-python/numpy-1.0.1"
DEPEND="${DEPEND}
	>=dev-python/sip-4.1.1"

src_unpack() {
	unpack ${A}

	# PyQwt CVS does not need the next 2 sed statements anymore
	sed -i \
		-e "s|%Import QtSvg/QtSvgmod.sip||" \
		-e "s|%Include qwt_plot_svgitem.sip||" \
		"${S}/sip/qwt5qt4/QwtModule.sip" || die "sed failed"

	# Avoid pre-stripped files
	sed -i \
		-e 's|ModuleMakefile(|ModuleMakefile(strip=0,|' \
		"${S}/configure/configure.py" || die "sed failed"
}

src_compile() {
	cd "${S}/configure"

	local myconf="-I/usr/include/qwt5 -lqwt --disable-numarray --disable-numeric"
	use debug && myconf="${myconf} --debug"
	has distcc ${FEATURES} || myconf="${myconf} -j1"

	python_version
	"${python}" configure.py ${myconf} || die "python configure.py failed"
	emake CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	python_need_rebuild
	cd "${S}/configure"
	emake DESTDIR="${D}" install || die "make install failed"

	cd "${S}"
	dodoc ANNOUNCEMENT-${PV} CHANGES-${PV} COPYING* README

	use doc && dohtml Doc/html/pyqwt/*

	if use examples ; then
		dodir /usr/share/doc/${PF}/examples
		cp -r qt4examples/ "${D}/usr/share/doc/${PF}/examples"
	fi
}
