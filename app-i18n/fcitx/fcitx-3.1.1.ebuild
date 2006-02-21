# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx/fcitx-3.1.1.ebuild,v 1.5 2006/02/21 20:27:41 liquidx Exp $

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://www.fcitx.org/"
# The HOMEPAGE and SRC_URI cannot be accessed from outside China :-(
#SRC_URI="http://www.fcitx.org/download/${P}.tar.bz2"
SRC_URI="http://bsdchat.com/dist/dryice/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="truetype"

RDEPEND="|| ( ( x11-libs/libX11 x11-libs/libXrender x11-libs/libXt )
		     virtual/x11 )
	truetype? ( || ( x11-libs/libXft virtual/xft ) )"

DEPEND="${RDEPEND}"
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
