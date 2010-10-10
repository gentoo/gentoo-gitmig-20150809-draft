# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hamlib/hamlib-1.2.11.ebuild,v 1.4 2010/10/10 20:37:11 klausman Exp $

PYTHON_DEPEND="2"
inherit autotools eutils multilib python

DESCRIPTION="Ham radio backend rig control libraries"
HOMEPAGE="http://sourceforge.net/apps/mediawiki/hamlib"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86 ~x86-fbsd"
IUSE="doc python tcl"

RESTRICT="test"

RDEPEND="
	=virtual/libusb-0*
	dev-libs/libxml2
	python? ( dev-lang/python )
	tcl? ( dev-lang/tcl )"

DEPEND=" ${RDEPEND}
	dev-util/pkgconfig
	dev-lang/swig
	>=sys-devel/libtool-2.2
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix hardcoded libdir paths
	sed -i -e "s#fix}/lib#fix}/$(get_libdir)/hamlib#" \
		-e "s#fix}/include#fix}/include/hamlib#" \
		hamlib.pc.in || die "sed failed"

	# fix tcl lib path
	epatch "${FILESDIR}"/${P}-bindings.diff

	eautoreconf
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/hamlib \
		--disable-static \
		--with-rpc-backends \
		--without-perl-binding \
		$(use_with python python-binding) \
		$(use_enable tcl tcl-binding)

	emake || die "emake failed"

	if use doc ; then
		cd doc && make doc || die "make doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS PLAN README README.betatester \
		README.developer NEWS TODO || die "dodoc failed"

	if use doc; then
		dohtml doc/html/* || die "dohtml failed"
	fi

	insinto /usr/$(get_libdir)/pkgconfig
	doins hamlib.pc || die "doins failed"

	echo "LDPATH=/usr/$(get_libdir)/hamlib" > "${T}"/73hamlib
	doenvd "${T}"/73hamlib || die "doenvd failed"
}
