# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eet/eet-0.0.1.20030310-r1.ebuild,v 1.2 2003/07/12 09:22:21 aliz Exp $

inherit flag-o-matic

DESCRIPTION="E file chunk reading/writing library"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc"
IUSE=""

DEPEND="virtual/glibc
	sys-devel/gcc"

S=${WORKDIR}/${PN}

pkg_setup() {
	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	[ `use alpha` ] || [ `use ppc` ] && append-flags -fPIC
	econf --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog Doxyfile NEWS README
	dohtml -r doc
}
