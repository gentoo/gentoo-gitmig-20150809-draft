# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.4.0_pre2.ebuild,v 1.3 2005/08/22 17:21:39 metalgod Exp $

inherit kde-functions eutils

need-qt 3

DESCRIPTION="QTerm is a BBS client in Linux."
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"
DEPEND=">=media-sound/esound-0.2.22
	dev-lang/python
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${P/_/}

src_compile() {

	cd ${S}/qterm && epatch ${FILESDIR}/qstring.patch
	cd ${S}
	# yeah, it's --disable-ssh to disable ssl
	econf `use_enable ssl ssh` || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install faled"
	dodoc AUTHORS BUGS COPYING ChangeLog README* RELEASE_NOTES
}
