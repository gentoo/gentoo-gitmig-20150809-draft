# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/setiathome/setiathome-4.18-r1.ebuild,v 1.4 2006/04/23 03:16:11 tcort Exp $

MY_PN="seti_boinc-client-cvs"
MY_PV="2005-08-20"
BOINC_PN="boinc_public-cvs"
BOINC_PV="2005-08-13"

DESCRIPTION="Search for Extraterrestrial Intelligence SETI@home"
HOMEPAGE="http://setiweb.ssl.berkeley.edu/"
SRC_URI="http://boinc.ssl.berkeley.edu/source/nightly/${BOINC_PN}-${BOINC_PV}.tar.gz
	http://setiweb.ssl.berkeley.edu/sah/seti_source/nightly/${MY_PN}-${MY_PV}.tar.gz"

IUSE="server"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND="~sci-misc/boinc-4.72.20050813
	>=media-libs/jpeg-6b"

S=${WORKDIR}/seti_boinc

src_compile() {
	# The setiathome GUI doesn't work - so disable it for now...
	econf BOINCDIR=${WORKDIR}/boinc_public \
		--without-x --disable-gui \
		`use_enable server` || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	local INSTDIR="/var/lib/boinc/projects/setiathome.berkeley.edu"
	local BINNAME=setiathome-${PV}.${CHOST}
	exeinto ${INSTDIR}
	doexe ${S}/client/${BINNAME}

	insinto ${INSTDIR}
	doins ${FILESDIR}/app_info.xml
	sed -i -e "s|NODOTVERSION|${PV/./}|g" \
		-e "s|BINNAME|${BINNAME}|g" \
		${D}${INSTDIR}/app_info.xml \
		|| die "sed of app_info.xml failed."
}

pkg_postinst() {
	chown -R boinc:boinc /var/lib/boinc
	cd /var/lib/boinc/projects/setiathome.berkeley.edu
	chown -R root:0 setiathome-${PV}.${CHOST} app_info.xml
}
