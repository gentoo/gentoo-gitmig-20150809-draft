# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/dopi/dopi-0.3.4.ebuild,v 1.1 2007/02/07 00:34:39 jurek Exp $

inherit eutils fdo-mime mono

DESCRIPTION="Dopi is a little application for updating Apple iPod devices"
HOMEPAGE="http://www.snorp.net/"
SRC_URI="http://www.snorp.net/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/mono
	>=dev-dotnet/ipod-sharp-0.6.2
	>=dev-dotnet/glade-sharp-2.4.0
	>=dev-dotnet/gtk-sharp-2.4.0
	>=dev-libs/glib-2.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/noicon-exception-fix.diff
}

src_compile() {
	econf || die

	#This build is not parallel safe
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
