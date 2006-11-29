# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.20.ebuild,v 1.13 2006/11/29 16:16:56 mr_bones_ Exp $

IUSE="X tcl tk debug"

DESCRIPTION="uu, xx, base64, binhex decoder"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc-macos sparc x86"

RDEPEND="tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_compile() {
	autoconf || die

	local myconf

	if use debug; then
		myconf="--disable-optimize"
	else
		myconf="--enable-optimize"
	fi

	if use tk && use X
	then
		myconf="${myconf} --enable-tk"
	fi

	econf \
		`use_enable tcl tcl` \
		`use_enable debug optimize` \
		$myconf || die
	emake || die "emake failed"
}

src_install() {
	einstall MANDIR=${D}/usr/share/man/ || die
	dodoc HISTORY INSTALL README
}
