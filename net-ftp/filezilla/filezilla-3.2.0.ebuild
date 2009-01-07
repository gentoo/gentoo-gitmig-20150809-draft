# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/filezilla/filezilla-3.2.0.ebuild,v 1.1 2009/01/07 20:35:32 voyageur Exp $

WX_GTK_VER="2.8"

inherit eutils multilib wxwidgets

MY_PV=${PV/_/-}
MY_P="FileZilla_${MY_PV}"

DESCRIPTION="FTP client with lots of useful features and an intuitive interface"
HOMEPAGE="http://filezilla-project.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="dbus"

RDEPEND="net-dns/libidn
	>=x11-libs/wxGTK-2.8.9
	>=app-admin/eselect-wxwidgets-0.7-r1"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4
	>=sys-devel/gettext-0.11
	>=net-libs/gnutls-2.0.4"

S="${WORKDIR}"/${PN}-${MY_PV}

src_compile() {
	econf $(use_with dbus) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/interface/resources/48x48/${PN}.png || die "doicon failed"

	dodoc AUTHORS ChangeLog NEWS
}
