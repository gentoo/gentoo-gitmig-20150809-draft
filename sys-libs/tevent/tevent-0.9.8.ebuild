# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.8.ebuild,v 1.3 2009/11/04 11:47:20 patrick Exp $

EAPI="2"

inherit confutils eutils autotools

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"
LICENSE="GPL-3"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"

DEPEND="sys-libs/talloc"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoconf -Ilibreplace

}

src_configure() {

	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		--enable-largefile \
	|| die "econf failed"

}

src_compile() {

	emake dirs || die "emake dirs failed"
	emake showflags || die "emake showflags failed"
	emake shared-build || die "emake shared-build failed"

}

src_install() {

	emake install DESTDIR="${D}" || die "emake install failed"
	dolib.a sharedbuild/lib/libtevent.a
	dolib.so sharedbuild/lib/libtevent.so

}
