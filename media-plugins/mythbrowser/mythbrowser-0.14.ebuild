# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythbrowser/mythbrowser-0.14.ebuild,v 1.1 2004/02/06 16:40:04 max Exp $

inherit flag-o-matic

DESCRIPTION="Web browser module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	>=kde-base/kdelibs-3.1
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A} && cd "${S}"

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:g" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local cpu="`get-flag march || get-flag mcpu`"
	if [ ! -z "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	echo "INCLUDEPATH += ${KDEDIR}/include" >> settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/lib" >> settings.pro

	qmake -o "Makefile" "${PN}.pro"
	emake || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"
	dodoc AUTHORS COPYING README ChangeLog
}
