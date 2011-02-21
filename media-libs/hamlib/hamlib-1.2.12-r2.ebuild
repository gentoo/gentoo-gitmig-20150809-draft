# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.12-r2.ebuild,v 1.4 2011/02/21 06:45:14 phajdan.jr Exp $

EAPI="2"
PYTHON_DEPEND="python? 2"

inherit autotools-utils eutils multilib python

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://sourceforge.net/apps/mediawiki/hamlib"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc x86 ~x86-fbsd"
IUSE="doc python tcl"

RESTRICT="test"

RDEPEND="
	=virtual/libusb-0*
	dev-libs/libxml2
	tcl? ( dev-lang/tcl )"

DEPEND=" ${RDEPEND}
	dev-util/pkgconfig
	dev-lang/swig
	>=sys-devel/libtool-2.2
	doc? ( app-doc/doxygen )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# fix hardcoded libdir paths
	sed -i -e "s#fix}/lib#fix}/$(get_libdir)/hamlib#" \
		-e "s#fix}/include#fix}/include/hamlib#" \
		hamlib.pc.in || die "sed failed"

	# fix tcl lib path
	epatch "${FILESDIR}"/${PN}-1.2.11-bindings.diff

	eautoreconf
}

src_configure() {
	econf \
		--libdir=/usr/$(get_libdir)/hamlib \
		--disable-static \
		--with-rpc-backends \
		--without-perl-binding \
		$(use_with python python-binding) \
		$(use_enable tcl tcl-binding)
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		cd doc && make doc || die "make doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	remove_libtool_files all

	dodoc AUTHORS NEWS PLAN README README.betatester \
		README.developer TODO || die "dodoc failed"

	if use doc; then
		dohtml doc/html/* || die "dohtml failed"
	fi

	insinto /usr/$(get_libdir)/pkgconfig
	doins hamlib.pc || die "doins failed"

	echo "LDPATH=/usr/$(get_libdir)/hamlib" > "${T}"/73hamlib
	doenvd "${T}"/73hamlib || die "doenvd failed"
}

pkg_postinst()  {
	use python && python_mod_optimize $(python_get_sitedir)/Hamlib.py
}

pkg_postrm()  {
	use python && python_mod_cleanup $(python_get_sitedir)/Hamlib.py
}
