# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.7.0-r1.ebuild,v 1.8 2007/01/26 14:35:26 armin76 Exp $

inherit eutils qt3 multilib

SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz
	http://squinky.gotdns.com/${P}-libyahoo.patch.gz"
HOMEPAGE="http://qtella.sourceforge.net/"
DESCRIPTION="Excellent QT/KDE Gnutella Client"

LICENSE="GPL-2"
IUSE="kde"
KEYWORDS="ppc ~sparc x86"
SLOT="0"

DEPEND="$(qt_min_version 3)
	kde? ( >=kde-base/kdelibs-3 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	if ! use kde; then
		epatch "${FILESDIR}"/${PV}-nokde.patch
	fi
	epatch "${FILESDIR}"/${P}-errno.patch
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${DISTDIR}"/${P}-libyahoo.patch.gz
}

src_compile() {
	local myconf
	if use kde ; then
		myconf="--with-kde=yes --with-kde-libs=`kde-config --expandvars --install lib` --with-kde-includes=`kde-config --expandvars --install include`"
	else
		myconf="--with-kde=no"
	fi

	econf ${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog THANKS
}
