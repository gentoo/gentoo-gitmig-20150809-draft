# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/efsd/efsd-0.0.1.20030220.ebuild,v 1.1 2003/02/20 11:50:24 vapier Exp $

DESCRIPTION="daemon that provides commonly needed file system functionality to clients"
HOMEPAGE="http://www.enlightenment.org/pages/efsd.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="pic"

DEPEND="virtual/glibc
	sys-devel/gcc
	sys-devel/perl"
RDEPEND="${DEPEND}
	app-admin/fam-oss
	>=dev-db/edb-1.0.3.2003*
	>=dev-libs/libxml2-2.3.10"

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
	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml -r doc
	docinto example
	doins example/*
}
