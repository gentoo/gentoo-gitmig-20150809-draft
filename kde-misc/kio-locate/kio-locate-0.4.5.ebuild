# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.4.5.ebuild,v 1.2 2006/09/02 13:20:43 nixnut Exp $

inherit kde

DESCRIPTION="kio slave to search files with locate"
HOMEPAGE="http://arminstraub.de/browse.php?page=programs_kiolocate"
SRC_URI="http://www.arminstraub.de/downloads/kio-locate/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""


DEPEND=">=dev-util/scons-0.96.1"
RDEPEND="|| ( sys-apps/slocate sys-apps/rlocate )"
need-kde 3.4

PATCHES="${FILESDIR}/kio-locate-0.4.4-bksys.diff"

LANGS="de fr"

src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=${ROOT}/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	scons install DESTDIR="${D}" languages="$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))"
	dodoc AUTHORS ChangeLog
}
