# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13c-r5.ebuild,v 1.9 2006/11/30 21:02:14 corsair Exp $

inherit gnuconfig eutils autotools

S=${WORKDIR}/${PN}-${PV:0:4}
DESCRIPTION="Any to PostScript filter"
HOMEPAGE="http://www.inf.enst.fr/~demaille/a2ps/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	cjk? ( http://dev.gentoo.org/~usata/distfiles/${P}-ja_nls.patch.gz ) "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="nls tetex cjk vanilla"

DEPEND=">=sys-devel/automake-1.6
	>=sys-devel/autoconf-2.57
	>=dev-util/gperf-2.7.2
	|| ( >=dev-util/yacc-1.9.1 sys-devel/bison )
	virtual/ghostscript
	>=app-text/psutils-1.17
	tetex? ( virtual/tetex )
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/ghostscript
	>=app-text/psutils-1.17
	tetex? ( virtual/tetex )
	nls? ( virtual/libintl )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/${PN}-4.13-select-freebsd.patch
	epatch ${FILESDIR}/${P}-locale-gentoo.diff
	epatch ${FILESDIR}/${PN}-4.13c-stdarg.patch
	use vanilla || epatch ${FILESDIR}/${PN}-4.13-stdout.diff
	epatch ${FILESDIR}/${PV}-gcc34.patch
	use cjk && epatch ${DISTDIR}/${P}-ja_nls.patch.gz

	# improve tempfile handling
	epatch ${FILESDIR}/${P}-fixps.patch
	epatch ${FILESDIR}/${P}-psmandup.diff

	# fix fnmatch replacement, bug #134546
	epatch ${FILESDIR}/${P}-fnmatch-replacement.patch

	# fix sandbox violation, bug #79012
	sed -i -e 's:$acroread -helpall:acroread4 -helpall:' configure configure.in

	# fix emacs printing, bug #114627
	epatch ${FILESDIR}/a2ps-4.13c-emacs.patch

	# fix psset with sed-4.1, bug #126403
	epatch ${FILESDIR}/a2ps-4.13c-psset.patch

	# fix >=autoconf-2.60, bug 138161
	epatch ${FILESDIR}/a2ps-4.13-fixcachecheck.patch

	gnuconfig_update || die "gnuconfig_update failed"
	AT_M4DIR="m4" eautoreconf || die "eautoreconf failed"
}

src_compile() {
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/xpti.dat
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/compreg.dat.tmp

	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat
	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat.tmp

	#export YACC=yacc
	econf --sysconfdir=/etc/a2ps \
		--includedir=/usr/include \
		`use_enable nls` || die "econf failed"

	export LANG=C

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

	# bug #122026
	sed -i "s:^countdictstack: \0:" ${D}/usr/bin/psset || die "sed failed"

	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README* THANKS TODO
}
