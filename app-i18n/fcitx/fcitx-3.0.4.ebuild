# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-3.0.4.ebuild,v 1.1 2005/03/01 11:28:08 usata Exp $

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
SRC_URI="http://www.fcitx.org/download/${P}.tar.bz2"

# The HOMEPAGE and SRC_URI cannot be accessed from outside China :-(
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="truetype"

DEPEND="virtual/x11
	truetype? ( virtual/xft )"

src_compile() {
	myconf=
	if use truetype ; then
		myconf=" --with-xft "
	else
		myconf=" --disable-xft "
	fi
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install()
{
	dobin src/fcitx
	insinto /usr/share/fcitx/data
	doins data/*.mb
	doins data/*.dat
	doins data/*.conf
	insinto /usr/share/fcitx/xpm
	doins xpm/*.xpm
	insinto /usr/share/fcitx/doc
	doins doc/*.txt
	doins doc/*.htm
}

pkg_postinst()
{
	einfo "You should export the following variables to use fcitx"
	einfo " export XMODIFIERS=\"@im=fcitx\""
	einfo " export XIM=fcitx"
	einfo " export XIM_PROGRAM=fcitx"
	einfo ""
	einfo "If you want to use WuBi or ErBi"
	einfo " cp /usr/share/fcitx/data/wbx.mb ~/.fcitx"
	einfo " cp /usr/share/fcitx/data/erbi.mb ~/.fcitx"
	einfo " cp /usr/share/fcitx/data/tables.conf ~/.fcitx"
	einfo ""
	einfo "Note that fcitx only works in the zh_CN locale."
}
