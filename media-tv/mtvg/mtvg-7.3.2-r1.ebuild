# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mtvg/mtvg-7.3.2-r1.ebuild,v 1.1 2009/02/14 20:13:49 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

S="${WORKDIR}/maxemumtvguide-${PV}"

DESCRIPTION="KDE TV-guide to display XMLTV listings."
HOMEPAGE="http://mtvg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mtvg/maxemumtvguide-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xml"
DEPEND=""
RDEPEND="xml? ( media-tv/xmltv )"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/mtvg-7.3.2-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

pkg_setup() {
	kde_pkg_setup

	if ! use xml; then
		echo
		ewarn "Support for XMLTV disabled.  Add the 'xml' USE flag if you"
		ewarn "need to pull TV listings."
		echo
	fi
}

pkg_postinst() {
	kde_pkg_postinst

	elog "The binary to run mtvg is 'maxemumtvguide'"
}
