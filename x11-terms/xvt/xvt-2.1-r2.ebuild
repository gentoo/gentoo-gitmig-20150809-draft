# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xvt/xvt-2.1-r2.ebuild,v 1.2 2010/01/11 17:58:35 armin76 Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A tiny vt100 terminal emulator for X"
HOMEPAGE="ftp://ftp.x.org/R5contrib/xvt-1.0.README"
SRC_URI="ftp://ftp.x.org/R5contrib/xvt-1.0.tar.Z
		mirror://gentoo/xvt-2.1.diff.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"
S=${WORKDIR}/${PN}-1.0

src_prepare() {
	# this brings the distribution upto version 2.1
	epatch "${WORKDIR}"/xvt-2.1.diff

	# fix #61393
	epatch "${FILESDIR}/xvt-ttyinit-svr4pty.diff"

	# CFLAGS, CC #241554
	epatch "${FILESDIR}/xvt-makefile.patch"

	# int main, not void main
	epatch "${FILESDIR}/xvt-int-main.patch"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin xvt || die "dobin failed"
	doman xvt.1
	dodoc README
}
