# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/filezilla/filezilla-3.0.4.ebuild,v 1.1 2007/12/22 04:27:55 jsin Exp $

WX_GTK_VER="2.8"

inherit eutils multilib autotools wxwidgets

MY_PV=${PV/_/-}
MY_P="FileZilla_${MY_PV}"

DESCRIPTION="FTP client with lots of useful features and an intuitive interface"
HOMEPAGE="http://filezilla-project.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="unicode"

RDEPEND="net-dns/libidn"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.4
	>=sys-devel/gettext-0.11
	>=net-libs/gnutls-2.0.4
	>=x11-libs/wxGTK-2.8.6"

S="${WORKDIR}"/${PN}-${MY_PV}

pkg_setup() {
	if use unicode; then
		need-wxwidgets "unicode"
	else
		need-wxwidgets "gtk2"
	fi
}

src_compile() {
	WXRC="/usr/bin/wxrc-2.8" econf \
		--with-wx-config="${WX_CONFIG}" \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/interface/resources/48x48/${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} "FileZilla" ${PN}.png

	dodoc AUTHORS ChangeLog NEWS
}
