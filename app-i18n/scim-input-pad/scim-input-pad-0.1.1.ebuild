# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-input-pad/scim-input-pad-0.1.1.ebuild,v 1.1 2006/02/16 19:30:56 liquidx Exp $

DESCRIPTION="Input pad for SCIM used to input symbols and special characters"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND=">=app-i18n/scim-1.2.0
	>=x11-libs/gtk+-2.6.0"


RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable nls) || die "Error: econf failed!"
	emake || die "Error: emake failed!"
}

src_install() {
	make DESTDIR=${D} install || die "Error: install failed!"
	dodoc ChangeLog README TODO
}

pkg_postinst() {

	einfo
	einfo "The SCIM input pad should be startable from the SCIM (and Skim)"
	einfo "systray icon right click menu. You will have to restart SCIM"
	einfo "(or Skim) in order for the menu entry to appear (you may simply"
	einfo "restart your X server). If you want to use it immediately, just"
	einfo "start the SCIM input pad, using the 'scim-input-pad' command."
	einfo
	einfo "To use, select the text zone you wish to write in, and just"
	einfo "click on the wanted character in the right multilevel tabbed"
	einfo "table, from the SCIM Input Pad interface."
	einfo
	einfo "To add new characters to the tables, see the documentation"
	einfo "(/usr/share/doc/${PF}/README.gz)."
	einfo

}
