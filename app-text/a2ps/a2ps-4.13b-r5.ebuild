# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r5.ebuild,v 1.16 2004/04/07 20:37:12 vapier Exp $

inherit gnuconfig eutils

S=${WORKDIR}/${P/b/}
DESCRIPTION="Any to PostScript filter"
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps/"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz
	cjk? ( http://www.on.cs.keio.ac.jp/~yasu/linux/GNU/a2ps-4.13-ja_nls.patch ) "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64 x86 ppc sparc alpha hppa"
IUSE="nls tetex cjk"

RDEPEND="virtual/ghostscript
	>=app-text/psutils-1.17
	tetex? ( virtual/tetex )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	>=dev-util/gperf-2.7.2
	>=dev-util/yacc-1.9.1
	cjk? ( >=sys-apps/sed-4 )"

src_unpack() {
	unpack ${P}.tar.gz
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
	cd ${S}

	epatch ${FILESDIR}/a2ps-4.13-autoconf-gentoo.diff
	epatch ${FILESDIR}/a2ps-4.13-stdout.diff
	use cjk && epatch ${DISTDIR}/a2ps-4.13-ja_nls.patch

	#stop running autoconf (bug #24264)
	#find . | xargs touch
}

src_compile() {
	export YACC=yacc
	export WANT_AUTOCONF=2.5 ; autoreconf

	econf --sysconfdir=/etc/a2ps \
		--includedir=/usr/include \
		`use_enable nls` || die "econf failed"
	make || die "make failed"
}

src_install() {
	dodir /usr/share/emacs/site-lisp

	einstall \
		sysconfdir=${D}/etc/a2ps \
		includedir=${D}/usr/include \
		lispdir=${D}/usr/share/emacs/site-lisp \
		|| die "einstall failed"

	dosed /etc/a2ps/a2ps.cfg

	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README* THANKS TODO
}
