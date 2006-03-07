# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/setmixer/setmixer-19941227_rc7.ebuild,v 1.11 2006/03/07 15:48:12 flameeyes Exp $

IUSE=""

inherit eutils toolchain-funcs

MY_PV="27DEC94"
DEB_REV="7"
DESCRIPTION="command mode mixer"
HOMEPAGE="http://packages.debian.org/testing/sound/setmixer.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/s/setmixer/setmixer_${MY_PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/s/setmixer/setmixer_${MY_PV}-${DEB_REV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

S=${WORKDIR}/${PN}-${MY_PV}.orig

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}/${PN}_${MY_PV}-${DEB_REV}.diff.gz"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" clean setmixer || die
}

src_install() {
	dobin setmixer
	dodoc README setmixer.lsm
	doman setmixer.1
	insinto /etc ; doins debian/setmixer.conf
	newinitd ${FILESDIR}/setmixer.rc setmixer
}
