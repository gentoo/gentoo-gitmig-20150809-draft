# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kterm/kterm-6.2.0-r1.ebuild,v 1.1 2003/06/20 13:49:22 yakina Exp $

IUSE=""

DESCRIPTION="Japanese Kanji X Terminal"
SRC_URI="ftp://ftp.x.org/contrib/applications/${P}.tar.gz
	http://www.asahi-net.or.jp/~hc3j-tkg/kterm/${P}-wpi.patch.gz
	http://www.st.rim.or.jp/~hanataka/${P}.ext02.patch.gz"
# until someone who reads japanese can find a better place
HOMEPAGE="http://www.asahi-net.or.jp/~hc3j-tkg/kterm/"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${P}

DEPEND="virtual/x11
	sys-libs/ncurses
	app-i18n/nkf"
RDEPEND="virtual/x11
	sys-libs/ncurses"

src_unpack(){
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${P}-wpi.patch		# wallpaper patch
	epatch ${WORKDIR}/${P}.ext02.patch		# JIS 0213 support
	epatch ${FILESDIR}/kterm-6.2.0-gentoo.patch
}

src_compile(){

	cat <<-EOF>>KTerm.ad

	! default values added by portage
	*VT100*kanjiMode:	euc
	*inputMethod:		kinput2
	*openIm:		true
	! To use wallpaper
	!*wallPaper:		/path/to/filename.xpm
	EOF

	xmkmf -a || die
	emake    || die
}

src_install(){
	einstall DESTDIR=${D} || die "install binary failed"

	# install man pages
	mv kterm.man kterm.1
	doman kterm.1
	mkdir -p ${D}/usr/share/man/ja/man1
	nkf -e kterm.jman > kterm.jman.euc
	install -c -m 644 kterm.jman.euc ${D}/usr/share/man/ja/man1/kterm.1 \
		|| die "install jman failed"

	if [ ! -e /usr/share/terminfo/k/kterm ];
	then
		cd {S}
		tic terminfo.kt -o${D}/usr/share/terminfo || die "tic failed"
	fi

	dodoc README.kt
}

pkg_postinst() {
	einfo ""
	einfo "KTerm wallpaper support is enabled."
	einfo "In order to use this feature,"
	einfo "you need specify favourite xpm file with -wp option"
	einfo ""
	einfo "    % kterm -wp filename.xpm"
	einfo ""
	einfo "or set it with X resource"
	einfo ""
	einfo "    KTerm*wallPaper: /path/to/filename.xpm"
	einfo ""
}
