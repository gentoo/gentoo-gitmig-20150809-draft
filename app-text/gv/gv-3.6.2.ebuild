# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.6.2.ebuild,v 1.1 2006/10/17 20:17:55 genstef Exp $

inherit eutils

DESCRIPTION="gv is used to view PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="ftp://ftp.gnu.org/gnu/gv/${P}.tar.gz
	mirror://debian/pool/main/g/gv/gv_3.6.2-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( (
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXmu
			x11-libs/libXpm
			x11-libs/libXt
		) virtual/x11
	)
	x11-libs/Xaw3d
	virtual/ghostscript"

DEPEND="${RDEPEND}
	|| (
		x11-libs/libXt
		virtual/x11
	)"
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gv-3.6.1-setenv.patch
	epatch "${FILESDIR}"/gv-3.6.1-a0.patch
	epatch "${FILESDIR}"/gv-3.6.1-fixedmedia.patch
	epatch "${FILESDIR}"/gv-update.patch
	epatch "${WORKDIR}"/gv_3.6.2-1.diff
	epatch ${P}/debian/patches/{*-*,*_*}
	# Make font render nicely even with gs-8, bug 135354
	sed -i -e "s:-dGraphicsAlphaBits=2:\0 -dAlignToPixels=0:" \
		src/{gv_{class,user,system}.ad,Makefile.{am,in}}
}

src_compile() {
	econf --enable-scrollbar-code || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
