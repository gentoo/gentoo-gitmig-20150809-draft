# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i-r1.ebuild,v 1.6 2003/12/31 03:52:34 usata Exp $

DESCRIPTION="Utility for creating and opening lzh archives."
HOMEPAGE="http://sourceforge.jp/projects/lha/"
LICENSE="lha"

DEPEND="virtual/glibc"
IUSE="nls"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~amd64"

MY_P="${P}.autoconf"
SRC_URI="http://downloads.sourceforge.jp/lha/1548/${MY_P}-20020903.tar.gz"
S="${WORKDIR}/${MY_P}"

src_compile() {

	local myconf=""

	use nls \
		&& myconf="${myconf} --enable-multibyte-filename=auto" \
		|| myconf="${myconf} --disable-multibyte-filename"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man/ja \
		${myconf} || die "./configure failed"

	#make check || die "make check failed"

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc *.txt *.euc *.eng ChangeLog 00readme.autoconf

}
