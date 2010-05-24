# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-sipe/pidgin-sipe-1.10.0.ebuild,v 1.3 2010/05/24 12:12:35 pva Exp $

EAPI="2"

DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kerberos"

#TODO: dev-libs/gmime - which is automagic dep, but
# >=dev-libs/gmime-2.4.16 is required and is not released atm
RDEPEND="net-im/pidgin
	>=dev-libs/glib-2.12.0
	dev-libs/libxml2 kerberos? ( app-crypt/mit-krb5 )" DEPEND="${RDEPEND}
	dev-util/intltool"

src_configure() {
	econf \
		--enable-purple \
		--disable-telepathy \
		--disable-quality-check \
		$(use_enable debug) \
		$(use_with kerberos krb5)
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS TODO README || die "dodoc failed"
}
