# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r5.ebuild,v 1.8 2003/10/29 18:40:25 usata Exp $

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
KEYWORDS="ia64 x86 ppc sparc alpha"
IUSE="nls tetex cjk"

DEPEND=">=dev-util/gperf-2.7.2
	>=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	cjk? ( >=sys-apps/sed-4 )
	tetex? ( virtual/tetex )"
RDEPEND=">=app-text/ghostscript-6.23
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
	find . | xargs touch
}

src_compile() {
	econf --sysconfdir=/etc/a2ps \
		--includedir=/usr/include \
		`use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/emacs/site-lisp

	einstall \
		sysconfdir=${D}/etc/a2ps \
		includedir=${D}/usr/include \
		lispdir=${D}/usr/share/emacs/site-lisp \
		|| die "einstall failed"

	sed -i -e "s,${D},,g" ${D}/etc/a2ps/a2ps.cfg

	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README* THANKS TODO
}
