# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-1.9.3.ebuild,v 1.1 2004/03/28 20:05:19 humpback Exp $

inherit gnome2

MY_PN="Gabber"

DESCRIPTION="The next generation of Gabber: The Gnome Jabber Client."
HOMEPAGE="http://gabber.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/gabber/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

IUSE="debug spell ssl xss X"

DEPEND="sys-devel/gettext
	>=dev-cpp/gtkmm-2.0
	>=dev-cpp/gconfmm-2.0
	>=dev-cpp/libglademm-2.0
	>=net-im/jabberoo-1.9.0
	ssl? ( dev-libs/openssl )
	spell? ( app-text/gtkspell )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	local myconf

	use ssl && myconf=${myconf} || myconf="${myconf} --disable-ssl"
	use spell && myconf=${myconf} || myconf="${myconf} --disable-gtkspell"
	use xss && myconf=${myconf} || myconf="${myconf} --disable-xss"
	use X && myconf="${myconf} --with-x"

	myconf="${myconf} --sysconfdir=${D}/etc"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}
