# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils

X86_FILENAME="cdrecord-prodvd-2.01a24-i686-pc-linux-gnu"

DESCRIPTION="Enhancement of cdrecord for writing DVDs"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"
SRC_URI="x86? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/${X86_FILENAME} )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-cdr/cdrtools-2.01_alpha24"
PROVIDE="virtual/cdrtools"

src_install() {
	if use x86; then
		dobin ${X86_FILENAME}
		dosym /usr/bin/${X86_FILENAME} /usr/bin/cdrecord.prodvd
	fi
	dobin ${FILESDIR}/cdrecord-wrapper.sh
}

pkg_postinstall() {
	echo
	einfo "For a license key of CDrecord-ProDVD please read"
	einfo "ftp://ftp.berlios.de/pub/cdrecord/ProDVD/README"
	echo
}
