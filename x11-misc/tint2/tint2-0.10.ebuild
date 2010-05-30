# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tint2/tint2-0.10.ebuild,v 1.1 2010/05/30 19:09:25 idl0r Exp $

EAPI="3"

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
SRC_URI="http://tint2.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="battery examples tint2conf"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	media-libs/imlib2[X]"
# autoconf >= 2.61 for --docdir, bug 296890
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	x11-proto/xineramaproto
	>=sys-devel/autoconf-2.61"
RDEPEND="${COMMON_DEPEND}
	tint2conf? ( x11-misc/tintwizard )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's:python /usr/bin/tintwizard.py:tintwizard:' src/tint2conf/main.c || die
}

src_configure() {
	econf --docdir=/usr/share/doc/${PF} \
		$(use_enable battery) \
		$(use_enable examples) \
		$(use_enable tint2conf)
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -f "${D}/usr/bin/tintwizard.py"
}
