# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/makepp/makepp-2.0.ebuild,v 1.1 2012/06/30 15:56:05 vapier Exp $

EAPI="4"

MY_PV=${PV/_}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="GNU make replacement"
HOMEPAGE="http://makepp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV%_*}/${MY_P}.txz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0"

S=${WORKDIR}/${MY_P}

src_unpack() {
	ln -s "${DISTDIR}/${A}" ${P}.tar.xz
	unpack ./${P}.tar.xz
}

src_prepare() {
	# default "all" rule is to run tests :x
	sed -i '/^all:/s:test::' config.pl || die
}

src_configure() {
	# not an autoconf configure script
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--htmldir=/usr/share/doc/${PF}/html \
		--mandir=/usr/share/man \
		--datadir=/usr/share/makepp \
		|| die "configure failed"
}

src_test() {
	# work around https://bugzilla.samba.org/show_bug.cgi?id=8728
	export CCACHE_UNIFY=1
	ROOT= default
}
