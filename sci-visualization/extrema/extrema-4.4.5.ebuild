# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/extrema/extrema-4.4.5.ebuild,v 1.1 2011/04/13 12:24:06 xarthisius Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit eutils fdo-mime wxwidgets

DESCRIPTION="Interactive data analysis and visualization tool"
HOMEPAGE="http://exsitewebware.com/extrema/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

# File collision, see bug #249423
RDEPEND="!sci-chemistry/psi
	>=x11-libs/wxGTK-2.8.7
	dev-util/desktop-file-utils"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e 's/$(pkgdatadir)/$(DESTDIR)$(pkgdatadir)/g' \
		src/Makefile.in || die
	epatch "${FILESDIR}"/${P}-gcc46.patch
}

src_configure() {
	# extrema cannot be compiled with versions of minuit
	# available in portage
	econf --enable-shared
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	make_desktop_entry ${PN}
	dodir /usr/share/icons/hicolor
	tar xjf extrema_icons.tar.bz2 -C "${D}usr/share/icons/hicolor"
	dosym /usr/share/icons/hicolor/48x48/apps/extrema.png /usr/share/pixmaps/extrema.png

	dodoc AUTHORS ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins Scripts/*.pcm Scripts/*.dat || die
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
