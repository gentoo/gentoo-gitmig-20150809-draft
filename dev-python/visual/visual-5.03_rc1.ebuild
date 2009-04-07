# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-5.03_rc1.ebuild,v 1.1 2009/04/07 11:25:19 bicatali Exp $

EAPI=2
inherit eutils python

MY_P="${P/rc1/candidate}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Real-time 3D graphics library for Python"
HOMEPAGE="http://www.vpython.org/"
SRC_URI="http://www.vpython.org/contents/download/${MY_P}.tar.bz2"

IUSE="doc examples"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="visual"

RDEPEND="=dev-libs/boost-1.35*
	dev-cpp/libglademm
	>=dev-cpp/gtkglextmm-1.2
	dev-python/numpy"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-example-dir=/usr/share/doc/${PF}/examples \
		$(use_enable doc docs) \
		$(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc authors.txt HACKING.txt NEWS.txt
	#the vpython script is only use for examples
	use examples || rm -r "${D}"/usr/bin
}
