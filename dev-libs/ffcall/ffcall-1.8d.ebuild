# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ffcall/ffcall-1.8d.ebuild,v 1.12 2004/02/15 12:08:52 dholm Exp $

DESCRIPTION="foreign function call libraries"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/ffcall.html"

# "Ffcall is under GNU GPL. As a special exception, if used in GNUstep
# or in derivate works of GNUstep, the included parts of ffcall are
# under GNU LGPL." -ffcall author
LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~hppa ~alpha ~ppc"

DEPEND="virtual/glibc"


src_unpack() {
	unpack ${A}
	#Fix hppa asm
	use hppa && (cd ${S}; epatch ${FILESDIR}/ffcall_hppa_1.8-4.2.diff.gz)

}

src_compile() {
	# Because CHOST is set to (for example)
	# alphaev67-unknown-linux-gnu, CPU gets set to alphaev67 which
	# doesn't work in the Makefile (29 Jan 2004 agriffis)
	local cpu_setting
	[[ $ARCH == alpha ]] && cpu_setting='CPU=alpha'

	econf || die "./configure failed"
	make ${cpu_setting} || die
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
