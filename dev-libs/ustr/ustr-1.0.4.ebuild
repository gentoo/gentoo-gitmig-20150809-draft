# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ustr/ustr-1.0.4.ebuild,v 1.2 2009/07/22 13:24:12 pebenito Exp $

inherit eutils

DESCRIPTION="Low-overhead managed string library for C"
HOMEPAGE="http://www.and.org/ustr"
SRC_URI="ftp://ftp.and.org/pub/james/ustr/${PV}/${P}.tar.bz2"

LICENSE="|| ( BSD-2 MIT LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_compile() {
	make all all-shared
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog README README-DEVELOPERS AUTHORS NEWS TODO
}
