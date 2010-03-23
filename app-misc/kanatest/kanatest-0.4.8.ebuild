# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kanatest/kanatest-0.4.8.ebuild,v 1.5 2010/03/23 20:39:34 ranger Exp $

inherit eutils

DESCRIPTION="Visual flashcard tool for memorizing the Japanese Hiragana and Katakana alphabet"
HOMEPAGE="http://www.clayo.org/kanatest"
SRC_URI="http://www.clayo.org/kanatest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	doicon kanatest.svg
	make_desktop_entry "${PN}" Kanatest "${PN}" "GNOME;Education;X-KDE-Edu-Language;"

	dodoc AUTHORS ChangeLog README
}
