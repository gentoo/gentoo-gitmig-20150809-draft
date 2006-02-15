# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kterm/kterm-6.2.0-r3.ebuild,v 1.6 2006/02/15 00:13:03 metalgod Exp $

inherit eutils flag-o-matic

IUSE="Xaw3d"

DESCRIPTION="Japanese Kanji X Terminal"
SRC_URI="ftp://ftp.x.org/contrib/applications/${P}.tar.gz
	http://www.asahi-net.or.jp/~hc3j-tkg/kterm/${P}-wpi.patch.gz
	http://www.st.rim.or.jp/~hanataka/${P}.ext02.patch.gz"
# until someone who reads japanese can find a better place
HOMEPAGE="http://www.asahi-net.or.jp/~hc3j-tkg/kterm/"
LICENSE="X11"
SLOT="0"
KEYWORDS="-alpha ~amd64 ppc ~sparc x86"

DEPEND="app-text/rman
	sys-libs/ncurses
	|| ( ( x11-libs/libXmu x11-libs/libXpm x11-libs/libxkbfile )
	     virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )"

src_unpack(){
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${P}-wpi.patch		# wallpaper patch
	epatch ${WORKDIR}/${P}.ext02.patch		# JIS 0213 support
	epatch ${FILESDIR}/${P}-openpty.patch
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PN}-ad-gentoo.diff

	if use Xaw3d ; then
		epatch ${FILESDIR}/kterm-6.2.0-Xaw3d.patch
	fi
}

src_compile(){
	xmkmf -a || die
	emake EXTRA_LDOPTIONS="$(bindnow-flags)" || die
}

src_install(){

	einstall DESTDIR=${D} BINDIR=/usr/bin || die

	# install man pages
	newman kterm.man kterm.1
	insinto /usr/share/man/ja/man1
	iconv -f ISO-2022-JP -t EUC-JP kterm.jman > kterm.ja.1
	newins kterm.ja.1 kterm.1

	dodoc README.kt
}

pkg_postinst() {
	einfo
	einfo "KTerm wallpaper support is enabled."
	einfo "In order to use this feature,"
	einfo "you need specify favourite xpm file with -wp option"
	einfo
	einfo "\t% kterm -wp filename.xpm"
	einfo
	einfo "or set it with X resource"
	einfo
	einfo "\tKTerm*wallPaper: /path/to/filename.xpm"
	einfo
}
