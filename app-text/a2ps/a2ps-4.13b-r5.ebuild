# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r5.ebuild,v 1.3 2003/08/12 06:59:47 usata Exp $

inherit gnuconfig eutils

S=${WORKDIR}/${P/b/}
DESCRIPTION="Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz
	cjk? ( http://www.on.cs.keio.ac.jp/~yasu/linux/GNU/a2ps-4.13-ja_nls.patch ) "
PATCHES="${FILESDIR}/a2ps-4.13-stdout.diff"

if use cjk; then
	PATCHES="${PATCHES} ${DISTDIR}/a2ps-4.13-ja_nls.patch"
fi

HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="nls tetex cjk"

DEPEND=">=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	cjk? ( >=sys-apps/sed-4 )
	tetex? ( >=app-text/tetex-1.0.7 )"
RDEPEND=">=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tetex? ( >=app-text/tetex-1.0.7 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
	cd ${S}
	xpatch ${PATCHES} || die
	#stop running autoconf (bug #24264)
	find . | xargs touch
}

src_compile() {
	econf --sysconfdir=/etc/a2ps `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/emacs/site-lisp

	einstall \
		sysconfdir=${D}/etc/a2ps \
		lispdir=${D}/usr/share/emacs/site-lisp \
		|| die "einstall failed"

	use cjk && sed -i -e "s,${D},,g" ${D}/etc/a2ps/a2ps.cfg

	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README* THANKS TODO
}
