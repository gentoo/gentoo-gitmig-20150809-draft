# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ltrace/ltrace-0.5.3.ebuild,v 1.6 2010/05/03 09:17:23 ssuominen Exp $

inherit eutils autotools

MY_PV=${PV%.?}
MY_P=${PN}_${MY_PV}
DEB_P=${MY_P}-${PV##*.}

DESCRIPTION="trace library calls made at runtime"
HOMEPAGE="http://ltrace.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/l/ltrace/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/l/ltrace/${DEB_P}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/elfutils"

# bug 233958
RESTRICT="test"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${DEB_P}.diff
	cd "${S}"
	epatch "${FILESDIR}"/0.4-parallel-make.patch

	epatch "${FILESDIR}"/${P}-cross.patch
	sed \
		-e 's:uname -m:echo @HOST_CPU@:' \
		sysdeps/linux-gnu/Makefile > sysdeps/linux-gnu/Makefile.in
	epatch "${FILESDIR}"/${P}-ppc.patch
	eautoconf
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install || die "make install failed"
	prepalldocs
}
