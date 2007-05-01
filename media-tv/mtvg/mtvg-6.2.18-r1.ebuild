# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mtvg/mtvg-6.2.18-r1.ebuild,v 1.2 2007/05/01 00:28:44 genone Exp $

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

need-kde 3.4

pkg_setup() {
	if ! use xml; then
		echo
		ewarn "Support for XMLTV disabled.  Add the 'xml' USE flag if you"
		ewarn "need to pull TV listings."
		echo
	fi
}

kde_src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "The binary to run mtvg is 'maxemumtvguide'"
}
