# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-0.0.2.20030310-r1.ebuild,v 1.1 2003/03/20 13:00:48 seemant Exp $

IUSE=""

inherit flag-o-matic

S=${WORKDIR}/${PN}
DESCRIPTION="simple-to-use general purpose widget library"
HOMEPAGE="http://www.enlightenment.org/pages/ewl.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND=">=x11-libs/evas-1.0.0.2003*
	>=media-libs/ebits-1.0.1.2003*
	>=dev-db/edb-1.0.3.2003*
	>=x11-libs/ecore-0.0.2.2003*
	>=dev-libs/ewd-0.0.1.2003*
	>=media-libs/etox-0.0.1.2003*"

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env USER=BLAH WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	use alpha && append-flags -fPIC

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS ChangeLog NEWS README
	dohtml -r doc
}
