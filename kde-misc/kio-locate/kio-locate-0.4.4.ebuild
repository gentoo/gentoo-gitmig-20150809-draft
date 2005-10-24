# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.4.4.ebuild,v 1.1 2005/10/24 15:36:07 carlo Exp $

inherit kde

DESCRIPTION="kio slave to search files with locate"
HOMEPAGE="http://arminstraub.de/browse.php?page=programs_kiolocate"
SRC_URI="http://www.arminstraub.de/downloads/kio-locate/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-util/scons-0.96.1"
RDEPEND="|| ( sys-apps/slocate sys-apps/rlocate )"
need-kde 3.1

PATCHES="${FILESDIR}/kde.py-bksys-1.5.1.diff"

src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	DESTDIR="${D}" scons install
	dodoc AUTHORS ChangeLog
}
