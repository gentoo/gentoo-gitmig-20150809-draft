# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kterm/kterm-6.2.0-r2.ebuild,v 1.2 2004/03/29 02:31:11 usata Exp $

IUSE="Xaw3d"

DESCRIPTION="Japanese Kanji X Terminal"
SRC_URI="ftp://ftp.x.org/contrib/applications/${P}.tar.gz
	http://www.asahi-net.or.jp/~hc3j-tkg/kterm/${P}-wpi.patch.gz
	http://www.st.rim.or.jp/~hanataka/${P}.ext02.patch.gz"
# until someone who reads japanese can find a better place
HOMEPAGE="http://www.asahi-net.or.jp/~hc3j-tkg/kterm/"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86 ~sparc -alpha ~ppc"

DEPEND="${RDEPEND}
	app-i18n/nkf"
RDEPEND="virtual/x11
	sys-libs/ncurses
	Xaw3d? ( x11-libs/Xaw3d )"

src_unpack(){
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${P}-wpi.patch		# wallpaper patch
	epatch ${WORKDIR}/${P}.ext02.patch		# JIS 0213 support
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PN}-ad-gentoo.diff

	if [ `use Xaw3d` ]
	then
		epatch ${FILESDIR}/kterm-6.2.0-Xaw3d.patch
	fi
}

src_compile(){

	xmkmf -a || die
	emake || die
}

src_install(){

	einstall DESTDIR=${D} BINDIR=/usr/bin || die

	# install man pages
	newman kterm.man kterm.1
	insinto /usr/share/man/ja/man1
	nkf -e kterm.jman > kterm.ja.1
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
