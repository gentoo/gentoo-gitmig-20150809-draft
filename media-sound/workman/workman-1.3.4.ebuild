# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/workman/workman-1.3.4.ebuild,v 1.2 2004/10/07 16:49:17 trapni Exp $

inherit eutils

DESCRIPTION="Graphical tool for playing audio CDs on a CD-ROM drive"

# I've crawled the web for a homepage of workman, I found alot users using it
# on solaris/debian/etc, however, no (official) homepage available.
# Debian is said to maintain this package, so, this is the URL to go.

HOMEPAGE="http://packages.qa.debian.org/w/workman.html"

# This is our compound patch derived from debian. We use it because:
#  * No more updates come from midwinter.com, no more workman seems to be on their site
#  * It does little harm, only some defaults are changed which we can redefine anyway
SRC_PATCH="${P/-/_}-17.diff"

# We use the WorkMan tarball available from debian because the original ftp is dead
# original source: ftp://ftp.midwinter.com/WorkMan/workman-1.3.4.tar.gz
SRC_URI="mirror://debian/pool/main/w/workman/${PN}_${PV}.orig.tar.gz
		 mirror://debian/pool/main/w/workman/${SRC_PATCH}.gz"

LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/xview-3.2
	sys-apps/groff
"

KEYWORDS="-* ~x86"

src_unpack() {
	unpack ${A}
	epatch ${SRC_PATCH}
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
