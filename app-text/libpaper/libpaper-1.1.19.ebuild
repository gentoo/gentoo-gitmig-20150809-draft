# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libpaper/libpaper-1.1.19.ebuild,v 1.1 2006/08/18 00:46:35 genstef Exp $

inherit eutils libtool

MY_P=${P/-/_}
DESCRIPTION="Library for handling paper characteristics"
HOMEPAGE="http://packages.debian.org/unstable/source/libpaper"
SRC_URI="mirror://debian/pool/main/libp/libpaper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	ln -s /usr/share/libtool/config.sub
	ln -s /usr/share/libtool/config.guess

	epatch "${FILESDIR}/libpaper-1.1.14.8-malloc.patch"

	elibtoolize
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc README ChangeLog

	dodir /etc
	(paperconf 2>/dev/null || echo a4) > ${D}/etc/papersize
}

pkg_postinst() {
	einfo "run \"paperconfig -p letter\" to use letter-pagesizes"
}
