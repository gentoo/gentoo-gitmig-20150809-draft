# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canuum/canuum-3.7_p2.ebuild,v 1.6 2006/10/14 10:00:39 flameeyes Exp $

MY_P="Canna${PV//[._]/}"
S="${WORKDIR}/${MY_P}/${PN}"

DESCRIPTION="Canna input method engine client for console"
HOMEPAGE="http://canna.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/canna/9558/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="app-i18n/canna
	dev-libs/libspt"
DEPEND="${RDEPEND}
	x11-misc/imake"

src_compile() {
	xmkmf -a || die "xmkmf canuum failed"
	sed -i -e 's|$(CANNASRC)|/usr/lib|g' \
		-e 's|\(cannaPrefix = \).*|\1/usr|g' \
		-e '/^cannaManDir/s|man|share/man|' \
		Makefile || die "sed failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install     || die "install failed"
	make DESTDIR=${D} install.man || die "install man failed"
	dodoc README*
}
