# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kchmviewer/kchmviewer-0.3.ebuild,v 1.1 2005/06/06 06:16:31 centic Exp $

inherit eutils
DESCRIPTION="Qt-based feature rich .CHM file viewer (kchmviewer)"
HOMEPAGE="http://kchmviewer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/qt-3.3.4"
#S="${WORKDIR}/${PN}"

#src_unpack() {
#	unpack ${A}
#	epatch ${FILESDIR}/kchmviewer-0.2-zoom.diff || "patch failed"
#}

#src_compile() {
#	econf || die "could not configure"
#	emake || die "emake failed"
#}

src_install() {
# normal install only installs the binary...
#	make install DESTDIR=${D}
#	into /usr
	dobin src/kchmviewer
	dodoc ChangeLog COPYING
}

