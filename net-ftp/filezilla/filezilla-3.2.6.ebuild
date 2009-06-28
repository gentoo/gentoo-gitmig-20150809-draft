# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/filezilla/filezilla-3.2.6.ebuild,v 1.1 2009/06/28 18:44:55 voyageur Exp $

EAPI=2

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
IUSE="dbus nls test"

RDEPEND="net-dns/libidn
	>=x11-libs/wxGTK-2.8.9
	>=app-admin/eselect-wxwidgets-0.7-r1
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4
	>=net-libs/gnutls-2.0.4
	nls? ( >=sys-devel/gettext-0.11 )
	test? ( dev-util/cppunit )"

S="${WORKDIR}"/${PN}-${MY_PV}

src_configure() {
	econf $(use_with dbus) $(use_enable nls locales) \
		--disable-autoupdatecheck || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/interface/resources/48x48/${PN}.png || die "doicon failed"

	dodoc AUTHORS ChangeLog NEWS
}
