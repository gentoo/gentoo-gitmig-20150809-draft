# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.18.ebuild,v 1.9 2004/02/22 14:21:21 aliz Exp $

DESCRIPTION="uu, xx, base64, binhex decoder"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"

KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

IUSE="tcltk debug"

DEPEND="tcltk? ( dev-lang/tcl dev-lang/tk )
	sys-devel/autoconf"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-optimize_size.patch
}

src_compile() {
	autoconf

	local myconf

	if [ "`use debug`" ]; then
		myconf="--disable-optimize"
	else
		myconf="--enable-optimize"
	fi

	econf \
		`use_enable tcltk tcl` \
		`use_enable tcltk tk` \
		`use_enable debug optimize` \
		$myconf || die
	emake || die "emake failed"
}

src_install() {
	einstall MANDIR=${D}/usr/share/man/ || die
	dodoc HISTORY INSTALL README
}
