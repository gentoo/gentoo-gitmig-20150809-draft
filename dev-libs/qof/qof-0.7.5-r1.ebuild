# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.7.5-r1.ebuild,v 1.7 2011/01/13 19:43:00 pacho Exp $

EAPI=1

inherit eutils

DESCRIPTION="A Query Object Framework"
HOMEPAGE="http://qof.alioth.debian.org/"
SRC_URI="mirror://sourceforge/qof/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"

IUSE="doc nls sqlite"

RDEPEND="dev-libs/libxml2
	dev-libs/glib:2
	sqlite? ( dev-db/sqlite:0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!dev-libs/qof:2
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Upstream not willing to remove those stupid flags...
	epatch "${FILESDIR}/${PN}-0.7.4-remove_spurious_CFLAGS.patch"
}

src_compile() {
	econf $(use_enable doc html-docs) --disable-error-on-warning $(use_enable nls) $(use_enable doc doxygen) --disable-dot $(use_enable sqlite) --disable-gdabackend --disable-gdasql || die
	emake -j1 || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
}
