# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.95-r3.ebuild,v 1.9 2007/07/12 05:34:48 mr_bones_ Exp $

inherit eutils fdo-mime

MY_P=${P/_rc/RC}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://amsn.sourceforge.net"

RESTRICT="test"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc -sparc x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	>=dev-tcltk/tls-1.4.1"

RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/share/amsn/

	sed -i -e 's:Icon=msn.png:Icon=amsn:' "${S}"/amsn.desktop
	domenu amsn.desktop

	for res in 32 48 64 96 128; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/icons/${res}x${res}/aMSN_${res}.png	amsn.png
	done

	insinto /usr/share/pixmaps
	newins ${S}/icons/32x32/aMSN_32.png amsn.png

	dodoc AGREEMENT TODO README FAQ CREDITS docs/*

	rm -rf GNUGPL AGREEMENT TODO README FAQ CREDITS HELP amsn.desktop icons \
		utils/windows utils/macosx docs lang/LANG-HOWTO debian

	insinto /usr/share/amsn/
	insopts -m644
	doins -r "${S}"/*

	dosym ../share/amsn/amsn /usr/bin/amsn
	dosym ../share/amsn/amsn-remote /usr/bin/amsn-remote
	dosym ../share/amsn/amsn-remote-CLI /usr/bin/amsn-remote-CLI
	chmod +x "${D}"/usr/share/amsn/amsn
	chmod +x "${D}"/usr/share/amsn/amsn-remote
	chmod +x "${D}"/usr/share/amsn/amsn-remote-CLI

}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	ewarn "You might have to remove ~/.amsn prior to running as user if amsn hangs on start-up."
}
