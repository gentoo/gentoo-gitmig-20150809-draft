# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/etox/etox-0.0.1.20030220.ebuild,v 1.3 2003/03/11 22:15:09 agriffis Exp $

DESCRIPTION="type setting and text layout library"
HOMEPAGE="http://www.enlightenment.org/pages/etox.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE="pic"

DEPEND="virtual/glibc
	sys-devel/gcc
	>=x11-libs/evas-1.0.0.2003*
	>=x11-libs/ecore-0.0.2.2003*
	>=dev-db/edb-1.0.3.2003*
	>=media-libs/ebits-1.0.1.2003*
	>=media-libs/estyle-0.0.1.2003*
	>=dev-libs/ewd-0.0.1.2003*"

S=${WORKDIR}/${PN}

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf `use_with pic` --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS README
	dohtml -r doc
}
