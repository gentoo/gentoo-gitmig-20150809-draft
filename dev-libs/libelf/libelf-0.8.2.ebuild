# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libelf/libelf-0.8.2.ebuild,v 1.2 2002/10/04 05:15:43 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ELF object file access library"
SRC_URI="http://www.stud.uni-hannover.de/~michael/software/${P}.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~michael/software/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls || myconf="--disable-nls"
	
	econf \
		--enable-shared \
		${myconf} || die
		
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		libdir=${D}usr/lib \
		includedir=${D}usr/include \
		install \
		install-compat || die
		
	dodoc COPYING.LIB ChangeLog VERSION README
}

