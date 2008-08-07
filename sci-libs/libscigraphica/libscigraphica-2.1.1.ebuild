# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libscigraphica/libscigraphica-2.1.1.ebuild,v 1.4 2008/08/07 20:41:48 mr_bones_ Exp $

inherit autotools eutils

DESCRIPTION="Libraries for data analysis and technical graphics"
SRC_URI="mirror://sourceforge/scigraphica/${P}.tar.gz"
HOMEPAGE="http://scigraphica.sourceforge.net/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=x11-libs/gtk+extra-2.1.0
	>=dev-python/numarray-1.3.1
	>=dev-libs/libxml2-2.4.10
	>=media-libs/libart_lgpl-2.3"

DEPEND="${RDEPEND}
		dev-util/intltool"

src_unpack() {

	unpack ${A}

	# fixes arrayobject problems
	epatch "${FILESDIR}"/${P}-arrayobject.patch
	# fixes libart_gpl version
	epatch "${FILESDIR}"/${P}-libart.patch
	# fixes intltoolization
	epatch "${FILESDIR}"/${P}-intl.patch
	# fixes bad AMFLAGS (see bug #234015)
	epatch "${FILESDIR}"/${P}-aclocal.patch

	cd "${S}"
	sed -i \
		-e "s:/lib:/$(get_libdir):g" \
		configure.in || die "sed for configure.in failed"

	einfo "Running intltoolize --copy --force --automake"
	intltoolize --copy --force --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ.compile \
		INSTALL NEWS README TODO
}
