# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.8.0.ebuild,v 1.1 2009/06/09 18:38:56 fauli Exp $

EAPI=2

inherit eutils

DESCRIPTION="A Query Object Framework"
HOMEPAGE="http://qof.alioth.debian.org/"
SRC_URI="https://alioth.debian.org/frs/download.php/3029/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc nls"

RDEPEND="gnome-extra/libgda:3
	dev-libs/libxml2
	>=dev-db/sqlite-2.8.0:0"
DEPEND="${DEPEND}
	dev-util/pkgconfig
	!dev-libs/qof:0
	doc? ( app-doc/doxygen
		dev-texlive/texlive-latex )"

src_prepare() {
	# Upstream not willing to remove those stupid flags...
	epatch "${FILESDIR}/${P}-remove_spurious_CFLAGS.patch"
}

src_configure() {
	econf $(use_enable doc html-docs) --disable-error-on-warning \
		$(use_enable nls) --enable-sqlite  $(use_enable doc doxygen) \
		$(use_enable doc latex-docs) --enable-gdabackend --enable-gdasql \
		--disable-deprecated-glib --disable-dot \
		|| die
}
src_compile() {
	emake -j1 || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
}
