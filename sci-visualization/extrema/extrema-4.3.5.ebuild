# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/extrema/extrema-4.3.5.ebuild,v 1.3 2008/05/15 12:21:37 rich0 Exp $

WX_GTK_VER="2.8"
inherit eutils fdo-mime wxwidgets

DESCRIPTION="Interactive data analysis and visualization tool"
HOMEPAGE="http://exsitewebware.com/extrema/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DEPEND=">=x11-libs/wxGTK-2.8.7
	dev-util/desktop-file-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.patch
}

src_compile() {
	# extrema cannot be compiled with versions of minuit
	# available in portage
	econf --enable-shared || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# The upstream Makefile is mostly OK, but for a few files
	# cp to a hard-coded directory is used, ignoring $(DESTDIR)
	# This problem is solved by einstall
	einstall || die "einstall failed"

	make_desktop_entry ${PN}
	dodir /usr/share/icons/hicolor
	tar xjf extrema_icons.tar.bz2 -C "${D}usr/share/icons/hicolor"
	dosym /usr/share/icons/hicolor/48x48/apps/extrema.png /usr/share/pixmaps/extrema.png

	dodoc AUTHORS ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples
		doins Scripts/*.pcm Scripts/*.dat
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
