# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/bnr2/bnr2-0.14.6.ebuild,v 1.8 2009/12/14 15:11:38 ssuominen Exp $

DESCRIPTION="A great newsreader for alt.binaries.*"
HOMEPAGE="http://www.bnr2.org/"
SRC_URI="http://www.bnr2.org/BNR2beta-${PV}.tgz
	http://www.bnr2.org/libborqt-6.9.0-qt2.3.so.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libSM
	|| ( media-libs/jpeg-compat <media-libs/jpeg-7 )"
DEPEND=""

S="${WORKDIR}"/BNR2

src_install() {
	dodir /opt/bnr2
	cp -R * "${D}"/opt/bnr2/
	rm "${D}"/opt/bnr2/bin/bnr2

	dobin "${FILESDIR}"/bnr2

	dodir /usr/share/doc
	mv "${D}"/opt/bnr2/docs "${D}"/usr/share/doc/${PF}
}
