# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r5.ebuild,v 1.12 2003/12/09 17:35:21 lanius Exp $

inherit gnuconfig eutils

S=${WORKDIR}/${P/b/}
DESCRIPTION="Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz
	cjk? ( http://www.on.cs.keio.ac.jp/~yasu/linux/GNU/a2ps-4.13-ja_nls.patch ) "
PATCHES="${FILESDIR}/a2ps-4.13-autoconf-gentoo.diff
	${FILESDIR}/a2ps-4.13-stdout.diff"

if use cjk; then
	PATCHES="${PATCHES} ${DISTDIR}/a2ps-4.13-ja_nls.patch"
fi

HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ppc sparc alpha hppa"
IUSE="nls tetex cjk"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57
	>=dev-util/gperf-2.7.2
	>=dev-util/yacc-1.9.1
	cjk? ( >=sys-apps/sed-4 )"
RDEPEND="virtual/ghostscript
	>=app-text/psutils-1.17
	tetex? ( virtual/tetex )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
	cd ${S}
	xpatch ${PATCHES} || die
	#stop running autoconf (bug #24264)
	#find . | xargs touch
}

src_compile() {

	export YACC=yacc
	export WANT_AUTOCONF_2_5=1 ; autoreconf

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
