# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.7-r2.ebuild,v 1.3 2002/10/05 05:39:21 drobbins Exp $

IUSE="xmms ssl nls crypt"

S=${WORKDIR}/${P}
DESCRIPTION="The GNOME Jabber Client"
SRC_URI="mirror://sourceforge/gabber/${P}.tar.gz"
HOMEPAGE="http://gabber.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

DEPEND=">=gnome-base/gnome-libs-1.4.1.7
	>=gnome-base/libglade-0.17-r1
	<gnome-base/libglade-2.0.0 
	>=gnome-extra/gal-0.19
	>=gnome-extra/gnomemm-1.2.2
	>=x11-libs/gtkmm-1.2.5
	<x11-libs/gtkmm-1.3.0
	ssl? ( >=dev-libs/openssl-0.9.6 )
	crypt? ( >=app-crypt/gnupg-1.0.5 )
	xmms? ( =media-sound/xmms-1.2.7-r11 )"

RDEPEND="${DEPEND} nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use ssl \
		|| myconf="${myconf} --disable-ssl"

	use nls \
		|| myconf="${myconf} --disable-nls"

	use xmms \
	        || myconf="${myconf} --disable-xmms"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
}

