# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dsh/dsh-0.23.4.ebuild,v 1.2 2003/02/13 09:28:54 vapier Exp $

DESCRIPTION="DSH - Distributed Shell"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="pic nls"

DEPEND="dev-libs/libdshconfig"
RDEPEND="net-misc/openssh"

src_compile() {
	local myconf="--with-gnu-ld"
	use pic \
		&& myconf="${myconf} --with-pic" \
		|| myconf="${myconf} --without-pic"
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	econf ${myconf}

	make || die
}

src_install() {
	make install DESTDIR=${D} || die
}
