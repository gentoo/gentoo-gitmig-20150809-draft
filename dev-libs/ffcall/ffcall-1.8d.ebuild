# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Nick Hadaway <raker@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ffcall/ffcall-1.8d.ebuild,v 1.1 2002/07/04 04:20:11 raker Exp $

DESCRIPTION="foreign function call libraries"
HOMEPAGE="http://www.gnu.org/directory/ffcall.html"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P}.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	dodoc ChangeLog NEWS README
	dohtml avcall/avcall.html \
		callback/callback.html \
		callback/trampoline_r/trampoline_r.html \
		trampoline/trampoline.html \
		vacall/vacall.html
	doman avcall/avcall.3 \
		callback/callback.3 \
		callback/trampoline_r/trampoline_r.3 \
		trampoline/trampoline.3 \
		vacall/vacall.3
	dolib.a avcall/.libs/libavcall.a \
		avcall/.libs/libavcall.la \
		vacall/libvacall.a \
		callback/.libs/libcallback.a \
		callback/.libs/libcallback.la \
		trampoline/libtrampoline.a
	insinto /usr/include
	doins avcall/avcall.h \
		callback/callback.h \
		trampoline/trampoline.h \
		callback/trampoline_r/trampoline_r.h \
		vacall/vacall.h \
		callback/vacall_r.h
}
