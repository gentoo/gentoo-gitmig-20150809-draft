# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-0.0.2.20030220-r1.ebuild,v 1.1 2003/03/20 13:05:58 seemant Exp $

inherit flag-o-matic

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="core event abstraction layer and X abstraction layer (nice convenience library)"
HOMEPAGE="http://www.enlightenment.org/pages/ecore.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/x11"

pkg_setup() {
	# the stupid gettextize script prevents non-interactive mode, so we hax it
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	use alpha && append-flags -fPIC
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r doc
}
