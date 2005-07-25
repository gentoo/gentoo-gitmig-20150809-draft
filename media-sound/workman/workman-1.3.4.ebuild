# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/workman/workman-1.3.4.ebuild,v 1.4 2005/07/25 19:18:20 dholm Exp $

IUSE=""

inherit eutils

SRC_PATCH="${P/-/_}-17.diff"

DESCRIPTION="Graphical tool for playing audio CDs on a CD-ROM drive"
HOMEPAGE="http://packages.qa.debian.org/w/workman.html"
SRC_URI="mirror://debian/pool/main/w/workman/${PN}_${PV}.orig.tar.gz
	 mirror://debian/pool/main/w/workman/${SRC_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 1.3.4: nothing displayed - eradicator
KEYWORDS="-amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/xview-3.2
	sys-apps/groff"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${WORKDIR}/${SRC_PATCH}
}

src_compile() {
	emake -f Makefile.linux PASS="${CFLAGS}" || die "emake failed"
	make workbone -f Makefile.linux || die "making workbone failed"
}

src_install() {
	dobin workman workbone
	doinfo workman.info

	newman workman.man workman.1
	newman workmandb.man workman.5

	dodoc README
	newdoc debian/changelog Changelog.debian
	dohtml HTML/*

	insinto /usr/share/pixmaps
	doins debian/workman.xpm
}

pkg_postinst() {
	einfo
	einfo "Please ensure the existence of /dev/cdrom with proper read permissions."
	einfo
}
