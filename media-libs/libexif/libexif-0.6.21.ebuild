# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif/libexif-0.6.21.ebuild,v 1.3 2012/07/14 20:04:44 jdhore Exp $

EAPI=4
inherit eutils libtool

DESCRIPTION="Library for parsing, editing, and saving EXIF data"
HOMEPAGE="http://libexif.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc nls static-libs"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6.13-pkgconfig.patch
	sed -i -e '/FLAGS=/s:-g::' configure || die #390249
	elibtoolize # For *-bsd
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable nls) \
		$(use_enable doc docs) \
		--with-doc-dir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files
	rm -f "${ED}"/usr/share/doc/${PF}/{ABOUT-NLS,COPYING}
}
