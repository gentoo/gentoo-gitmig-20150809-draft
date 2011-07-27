# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wpd2odt/wpd2odt-0.8.0.ebuild,v 1.1 2011/07/27 10:48:04 scarabeus Exp $

EAPI=4

DESCRIPTION="WordPerfect Document (wpd/wpg) to Open document (odt/odg) converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/writerperfect-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="
	app-text/libwpd:0.9
	media-libs/libwpg:0.2
	gnome-extra/libgsf
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

S=${WORKDIR}/writerperfect-${PV}

src_configure() {
	econf \
		--with-libgsf \
		--with-libwpg
}
