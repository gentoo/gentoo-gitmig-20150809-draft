# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-2.1.0_rc.ebuild,v 1.1 2004/06/20 20:04:34 usata Exp $

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://www.fcitx.org/download/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="truetype"

DEPEND="virtual/x11
	truetype? ( virtual/xft )"

S="${WORKDIR}/${P/_/}"

src_compile() {
	econf $(use_with truetype xft) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc doc/*.txt AUTHORS ChangeLog THANKS
	dohtml doc/*.htm
}

pkg_postinst() {
	einfo "You should export the following variables to use fcitx"
	einfo " export XMODIFIERS=@im=fcitx"
	einfo " export XIM=fcitx"
	einfo " export XIM_PROGRAM=fcitx"
	einfo " "
	einfo "Note that fcitx only works in the zh_CN locale."
}
