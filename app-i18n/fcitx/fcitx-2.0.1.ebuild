# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-2.0.1.ebuild,v 1.1 2004/02/07 09:46:08 liquidx Exp $

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://www.fcitx.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="truetype"

DEPEND="virtual/x11
	truetype? ( virtual/xft )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	make clean || die "unable to clean"
	sed -e "s:-O2:${CFLAGS}:" -i Makefile Makefile.noxft
}

src_compile() {
	if [ -z "`use truetype`" ]; then
		make -f Makefile.noxft || die "xft make failed"
	else
		make || die "make failed"
	fi
}

src_install() {
	dobin fcitx
	insinto /usr/share/fcitx
	doins data/*.mb
	dodoc doc/*.txt
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
