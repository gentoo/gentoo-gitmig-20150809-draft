# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ewd/ewd-0.0.1.20030220.ebuild,v 1.1 2003/02/20 11:38:14 vapier Exp $

DESCRIPTION="library providing thread-safe basic data structures like hashes, lists and trees"
HOMEPAGE="http://www.enlightenment.org/pages/ewd.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="pic"

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
	econf `use_with pic` --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r doc
}
