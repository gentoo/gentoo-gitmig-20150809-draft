# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/agistudio/agistudio-1.2.1.ebuild,v 1.5 2006/05/28 15:24:32 tupone Exp $

inherit kde
need-qt 3.1

DESCRIPTION="QT AGI Studio allows you to view, create and edit AGI games."
HOMEPAGE="http://agistudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/agistudio/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
	sed -i \
		-e "s#^QTDIR.*#QTDIR = ${QTDIR}#" \
		-e "s#^INCPATH.*#INCPATH = -I\$(QTDIR)/include#" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin agistudio || die "dobin failed"
	cd ..
	dodir /usr/share/${PN}
	cp -r help template "${D}/usr/share/${PN}" || die "cp failed"
	doman agistudio.1
	dodoc README
}
