# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ustr/ustr-1.0.4-r1.ebuild,v 1.1 2009/08/02 04:42:37 pebenito Exp $

inherit eutils

DESCRIPTION="Low-overhead managed string library for C"
HOMEPAGE="http://www.and.org/ustr"
SRC_URI="ftp://ftp.and.org/pub/james/ustr/${PV}/${P}.tar.bz2"

LICENSE="|| ( BSD-2 MIT LGPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}" HIDE= all-shared || die
}

src_install() {
	emake install DESTDIR="${D}" HIDE= \
		mandir="/usr/share/man" \
		SHRDIR="/usr/share/doc/${PF}" \
		DOCSHRDIR="/usr/share/doc/${PF}" || die
	dodoc ChangeLog README README-DEVELOPERS AUTHORS NEWS TODO
}
