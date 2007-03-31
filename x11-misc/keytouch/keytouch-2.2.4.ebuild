# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/keytouch/keytouch-2.2.4.ebuild,v 1.3 2007/03/31 10:20:23 opfer Exp $

inherit eutils versionator

DOC_V=$(get_version_component_range -2)
DESCRIPTION="Easily configure extra keyboard function keys"
HOMEPAGE="http://keytouch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${PN}-${DOC_V}_tech_manual.pdf
		mirror://sourceforge/${PN}/${PN}-${DOC_V}-user_manual.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc kde"

RDEPEND=">=x11-libs/gtk+-2
	gnome-base/gnome-menus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	kde? ( || (
		kde-base/kdesu
		kde-base/kdebase ) )
	!kde? ( x11-libs/gksu )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i 's/install-data-local//1' \
		keytouch{-acpid,d,-init}/Makefile.in \
		|| die "sed failed"

	sed -i 's/gnome-calculator/gcalctool/' \
		keyboards/* || die "sed failed"
}

src_compile() {
	local d
	for d in . keytouch-config keytouch-keyboard ; do
		cd "${S}"/${d}
		econf || die
		emake || die "emake ${d} failed"
	done
}

src_install() {
	doinitd "${FILESDIR}"/${PN} || die "doinitd failed"

	newicon keytouch-keyboard/pixmaps/icon.png ${PN}.png
	make_desktop_entry ${PN} keyTouch ${PN}.png System

	dodoc AUTHORS ChangeLog
	use doc && dodoc "${DISTDIR}"/*.pdf

	local d
	for d in . keytouch-config keytouch-keyboard ; do
		emake -C ${d} DESTDIR="${D}" install \
			|| die "emake install ${d} failed"
	done
}

pkg_postinst() {
	echo
	elog "To use keyTouch, add \"keytouchd\" to your"
	elog "X startup programs and run"
	elog "\"rc-update add keytouch default\""
	elog
	elog "If support for your keyboard is not included in"
	elog "this release, check for new keyboard files at"
	elog "http://keytouch.sourceforge.net/dl-keyboards.html"
	elog
	elog "x11-misc/keytouch-editor can be used to create"
	elog "your own keyboard files"
	echo
}
