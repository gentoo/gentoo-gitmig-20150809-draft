# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.0.4.20030220.ebuild,v 1.2 2003/02/22 08:20:53 vapier Exp $

DESCRIPTION="image loader plugins for Imlib 2"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X pic"

DEPEND=">=media-libs/imlib2-1.0.6.2003*
	>=dev-db/edb-1.0.3.2003*
	>=dev-libs/eet-0.0.1.2003*"
#RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"
	cd libltdl && env WANT_AUTOCONF_2_5=1 autoconf && cd ..

	econf \
		`use_with pic` \
		`use_with X x` \
		--enable-eet \
		--enable-edb \
		--with-gnu-ld \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README
}
