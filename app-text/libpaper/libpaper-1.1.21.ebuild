# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libpaper/libpaper-1.1.21.ebuild,v 1.6 2007/06/17 21:00:07 angelos Exp $

inherit eutils libtool

MY_P=${P/-/_}
DESCRIPTION="Library for handling paper characteristics"
HOMEPAGE="http://packages.debian.org/unstable/source/libpaper"
SRC_URI="mirror://debian/pool/main/libp/libpaper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/libpaper-1.1.14.8-malloc.patch

	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README ChangeLog

	dodir /etc
	(paperconf 2>/dev/null || echo a4) > "${D}"/etc/papersize
}

pkg_postinst() {
	elog "run \"paperconfig -p letter\" to use letter-pagesizes"
}
