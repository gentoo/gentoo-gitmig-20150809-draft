# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.7.8-r6.ebuild,v 1.8 2004/03/28 02:38:13 mr_bones_ Exp $

inherit eutils

DESCRIPTION="rxvt -- nice small x11 terminal"
HOMEPAGE="http://www.rxvt.org/"
SRC_URI="mirror://sourceforge/rxvt/${P}.tar.gz
	cjk? ( http://hp.vector.co.jp/authors/VA021953/rxvt/src/${P}-rk.patch )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc"
IUSE="motif cjk xgetdefault"

DEPEND="virtual/glibc
	virtual/x11
	motif? ( x11-libs/openmotif )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-security.patch
	use motif && epatch ${FILESDIR}/${P}-azz4.diff
	use cjk && epatch ${DISTDIR}/${P}-rk.patch
}

src_compile() {

	local term
	if [ -n "${RXVT_TERM}" ] ; then
		term="${RXVT_TERM}"
	else
		term="rxvt"
	fi

	econf \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-menubar \
		--enable-languages \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling \
		--with-term=${term} \
		`use_enable xgetdefault` || die

	emake || die
}

src_install() {

	einstall mandir=${D}/usr/share/man/man1 || die

	cd ${S}/doc
	dodoc README* *.txt BUGS FAQ
	dohtml *.html
}

pkg_postinst() {

	einfo
	einfo "If you want to change default TERM variable other than rxvt,"
	einfo "set RXVT_TERM environment variable and then emerge rxvt."
	einfo "Especially, if you use rxvt under monochrome X you might need to run"
	einfo "\t RXVT_TERM=rxvt-basic emerge rxvt"
	einfo "otherwise curses based program will not work."
	einfo
}
