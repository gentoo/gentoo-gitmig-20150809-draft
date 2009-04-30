# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/xgks-pmel/xgks-pmel-2.5.5.ebuild,v 1.1 2009/04/30 06:36:23 nerdboy Exp $

inherit eutils fortran toolchain-funcs multilib

DESCRIPTION="PMEL fork of XGKS, an X11-based version of the ANSI Graphical Kernel System."
HOMEPAGE="http://www.gentoogeek.org/viewvc/Linux/xgks-pmel/"
SRC_URI="http://www.gentoogeek.org/files/${P}.tar.gz"
LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="x11-libs/libX11"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-apps/groff"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/aclocal.patch
}

src_compile() {
	sed -i -e "s:lib64:$(get_libdir):g" port/master.mk.in \
	    fontdb/Makefile.in || die "sed 1 failed"

	CFLAGS=${CFLAGS} LD_X11='-L/usr/$(get_libdir) -lX11' \
	    FC=${FORTRANC} CC=$(tc-getCC) OS=linux \
	    ./configure --prefix=/usr --exec_prefix=/usr/bin \
	    || die "configure failed"

	sed -i -e "s:port/all port/install:port/all:g" Makefile \
	    || die "sed 2 failed"

	make || die "make failed"

	cd src/fortran
	make || die "make fortran failed"
}

src_install() {
	dobin progs/{defcolors,font,hanoi,mi,pline,pmark,star} || die
	dolib.a src/lib/libxgks.a || die

	dodoc COPYRIGHT HISTORY INSTALL README || die
	doman doc/{xgks.3,xgks_synop.3}
	if use doc; then
	    newdoc doc/binding/cbinding.me cbinding || die
	    newdoc doc/userdoc/userdoc.me userdoc || die
	fi

	insinto /usr/include
	doins src/lib/xgks.h || die

	insinto /usr/share/xgksfonts
	doins fontdb/{[1-9],*.gksfont} || die
}
