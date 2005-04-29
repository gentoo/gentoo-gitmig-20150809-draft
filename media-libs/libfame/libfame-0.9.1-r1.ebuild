# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.1-r1.ebuild,v 1.2 2005/04/29 00:28:46 vapier Exp $

inherit flag-o-matic gcc eutils

DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mmx sse"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch

	# Do not add -march=i586, bug #41770.
	sed -i -e 's:-march=i[345]86 ::g' configure

	#closing bug #45736
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch "${FILESDIR}"/${P}-mmx_configure.patch
		epatch "${FILESDIR}"/${P}-gcc34.patch
	fi

	# yet another pic patch, thanks to the 'pic gods' ;-)
	# see #90318
	epatch "${FILESDIR}"/${P}-pic.patch
}

src_compile() {
#	filter-flags -fprefetch-loop-arrays
	econf \
		$(use_enable mmx) \
		$(use_enable sse) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	dodir /usr
	dodir /usr/lib

	einstall install || die "make install failed"
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
