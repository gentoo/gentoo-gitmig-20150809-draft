# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nero/nero-2.0.0.0_p6.ebuild,v 1.1 2005/03/24 23:16:53 wschlich Exp $

inherit eutils rpm

NERO_RPM="NeroLINUX-2.0.0.0-6-intel.rpm"
NERO_FETCH_URL="http://www.nero.com/en/NeroLINUX.html"

DESCRIPTION="Nero Burning ROM for Linux"
HOMEPAGE="http://www.nero.com/"
SRC_URI="${NERO_RPM}"
LICENSE="Nero"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="virtual/x11 virtual/libc >=x11-libs/gtk+-1.2 >=dev-libs/glib-1.2"
RESTRICT="fetch nostrip"

pkg_nofetch() {
	einfo "Please download ${NERO_RPM}"
	einfo "from ${NERO_FETCH_URL}"
	einfo "and move it to ${DISTDIR}"
	ewarn "You have to register a valid Nero 6 serial number with the"
	ewarn "above mentioned web site to be able to download the file."
	ewarn "Also, the program will only work in demo mode for a"
	ewarn "certain period of time without a valid Nero 6 serial number"
}

src_unpack() {
	if [ ! -r "${DISTDIR}/${NERO_RPM}" ]; then
		die "Cannot read ${DISTDIR}/${NERO_RPM}. Please check the permissions and try again."
	fi
	cd "${WORKDIR}"
	rpm_src_unpack
}

src_compile() { :; }

src_install() {
	cd "${WORKDIR}"

	dodir /usr/share/nero
	insinto /usr/share/nero
	doins ./usr/share/nero/{*.so,DosBootImage.ima,Nero.txt,CDROM.CFG}

	dodir /usr/share/nero/desktop
	insinto /usr/share/nero/desktop
	doins ./usr/share/nero/desktop/NeroLINUX.template

	dodir /usr/share/nero/docs
	insinto /usr/share/nero/docs
	doins ./usr/share/nero/docs/{Manual.pdf,EULA}

	dodir /usr/share/nero/pixmaps
	insinto /usr/share/nero/pixmaps
	doins ./usr/share/nero/pixmaps/nero.png

	dodir /usr/lib
	insinto /usr/lib
	doins ./usr/lib/*.so

	dobin ./usr/bin/nero
}
