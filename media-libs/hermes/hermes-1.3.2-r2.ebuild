# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hermes/hermes-1.3.2-r2.ebuild,v 1.25 2004/11/17 00:18:57 eradicator Exp $

IUSE=""

inherit eutils libtool gnuconfig

MY_P=${P/h/H}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Library for fast colorspace conversion and other graphics routines"
HOMEPAGE="http://hermes.terminal.at/"
SRC_URI="http://dark.x.dtu.dk/~mbn/clanlib/download/download-sphair/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~mips amd64 ~hppa ppc64"

DEPEND=">=sys-devel/autoconf-2.50
	>=sys-devel/automake-1.8"

RDEPEND="virtual/libc"

asrc_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${P}-amd64.patch
	epatch ${FILESDIR}/${P}-destdir.patch

	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5

	aclocal || die "aclocal failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"

	gnuconfig_update
	elibtoolize
}

asrc_compile() {
	econf || die
	sh ltconfig ltmain.sh || die "ltconfig failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog FAQ NEWS README TODO*

	dohtml docs/api/*.htm
	docinto print
	dodoc docs/api/*.ps
	docinto txt
	dodoc docs/api/*.txt
	docinto sgml
	dodoc docs/api/sgml/*.sgml
}
