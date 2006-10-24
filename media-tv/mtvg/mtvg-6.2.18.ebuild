# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mtvg/mtvg-6.2.18.ebuild,v 1.1 2006/10/24 01:39:47 beandog Exp $

inherit kde

S="${WORKDIR}/maxemumtvguide-${PV}"

DESCRIPTION="KDE TV-guide to display XMLTV listings."
HOMEPAGE="http://mtvg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mtvg//maxemumtvguide-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

need-kde 3.4

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "The binary to run mtvg is 'maxemumtvguide'"
}
