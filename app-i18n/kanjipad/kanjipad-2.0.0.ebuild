# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-2.0.0.ebuild,v 1.9 2006/10/14 09:20:14 flameeyes Exp $

DESCRIPTION="Japanese handwriting recognition tool"
HOMEPAGE="http://fishsoup.net/software/kanjipad/"
SRC_URI="http://fishsoup.net/software/kanjipad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	perl -i -pe "s|PREFIX=/usr/local|PREFIX=/usr|;
		s|-DG.*DISABLE_DEPRECATED||g" Makefile || die

	emake || die
}

src_install() {
	dobin kanjipad kpengine || die
	insinto /usr/share/kanjipad
	doins jdata.dat || die
	dodoc ChangeLog README TODO jstroke/README-kanjipad
}
