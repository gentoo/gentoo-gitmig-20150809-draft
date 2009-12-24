# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/xlispstat/xlispstat-3.52.20.ebuild,v 1.6 2009/12/24 14:31:59 flameeyes Exp $

inherit eutils

DESCRIPTION="XLISP-STAT is a statistical environment based on a dialect of the Lisp language called XLISP."
HOMEPAGE="http://www.stat.uiowa.edu/~luke/xls/xlsinfo/xlsinfo.html"
SRC_URI="ftp://ftp.stat.umn.edu/pub/xlispstat/current/xlispstat-${PV//./-}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RDEPEND="X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P//./-}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fmax.patch
}

src_compile() {
	local opts=''
	use X && opts='--with-x' || opts='--without-x'
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${opts} || die "./configure failed"
	# bug #298209
	emake -j1 UCFLAGS="${CFLAGS} -mieee-fp" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib/xlispstat
	emake -j1 prefix=${D}/usr/ install || die
	dodoc COPYING INSTALL README* RELEASE
	dodoc doc/xlispins.doc doc/xlispdoc.{ps,txt}
}
