# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nget/nget-0.26.ebuild,v 1.1 2005/01/17 20:05:02 swegener Exp $

NPVER=20011209
DESCRIPTION="Network utility to retrieve files from an NNTP news server"
HOMEPAGE="http://nget.sourceforge.net/"
SRC_URI="mirror://sourceforge/nget/${P}+uulib.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 arm"
IUSE="static debug"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	dev-libs/popt"

src_compile() {
	local myconf
#	use nls || myconf="--disable-nls"
#	use ssl && myconf="${myconf} --with-ssl"
#	use ssl || myconf="${myconf} --without-ssl --disable-opie --disable-digest"
#	use debug && myconf="${myconf} --disable-debug"
#	use ssl && CFLAGS="${CFLAGS} -I/usr/include/openssl"
	./configure \
		--prefix=/usr  \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die
	if use static; then
		make LDFLAGS="--static" || die
	else
		make || die
	fi
}

src_install() {
	if use build; then
		insinto /usr
		dobin ${S}/src/nget
		return
	fi
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die
	dodoc COPYING ChangeLog FAQ README TODO .ngetrc
}
