# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.0.20.ebuild,v 1.1 2004/11/14 06:30:27 vapier Exp $

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=net-misc/curl-7.10.8"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	doc? (
		>=app-doc/doxygen-1.3*
		app-text/tetex
		app-text/ghostscript
	)"

src_compile() {
	./configure.sh linux || die "configure failed"
	emake -j1 all WHERE=/usr/ || die "make failed"
	if use doc ; then
		make doc || die "make doc failed"
	fi
}

src_install() {
	make install DESTDIR=${D} WHERE=/usr/ || die
	dodoc AUTHORS README ChangeLog TODO \
		${D}/usr/share/doc/${PN}/MANUAL.txt
	rm -rf ${D}/usr/share/doc/${PN}

	newinitd buildfactory/freePOPsd.initd freepopsd
	newconfd buildfactory/freePOPsd.confd freepopsd
}
