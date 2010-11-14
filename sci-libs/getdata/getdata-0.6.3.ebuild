# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/getdata/getdata-0.6.3.ebuild,v 1.2 2010/11/14 13:39:27 jlec Exp $

EAPI=2

DESCRIPTION="Reference implementation of the Dirfile, format for time-ordered binary data"
HOMEPAGE="http://getdata.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 lzma python"

DEPEND="
	bzip2? ( app-arch/bzip2 )
	lzma? ( app-arch/xz-utils )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf="\
		--disable-idl \
		--without-libslim \
		--with-libz \
		--docdir=/usr/share/doc/${P} \
		$(use_enable python) \
		$(use_with bzip2 libbz2) \
		$(use_with lzma liblzma)"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "Installing docs failed"
}
