# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13c.ebuild,v 1.6 2003/11/16 01:07:29 gmsoft Exp $

inherit gnuconfig eutils

S=${WORKDIR}/${PN}-${PV:0:4}
DESCRIPTION="Any to PostScript filter"
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	cjk? ( http://dev.gentoo.org/~usata/distfiles/${P}-ja_nls.patch.gz ) "

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~sparc ~alpha amd64 hppa"
IUSE="nls tetex cjk"

DEPEND=">=sys-devel/automake-1.6
	>=sys-devel/autoconf-2.57
	>=dev-util/gperf-2.7.2
	>=dev-util/yacc-1.9.1
	>=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
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
	epatch ${FILESDIR}/${P}-locale-gentoo.diff
	epatch ${FILESDIR}/a2ps-4.13-stdout.diff
	use cjk && epatch ${DISTDIR}/${P}-ja_nls.patch.gz
}

src_compile() {

	export YACC=yacc
	econf --sysconfdir=/etc/a2ps \
		--includedir=/usr/include \
		`use_enable nls` || die "econf failed"

	# sometimes emake doesn't work
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
