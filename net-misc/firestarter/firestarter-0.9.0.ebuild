# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/firestarter/firestarter-0.9.0.ebuild,v 1.1 2002/07/31 18:12:32 bass Exp $

#MY_P=firestarter-${PV}
S=${WORKDIR}/${P}beta1
DESCRIPTION="Gui for firewalls (iptables & ipchains), and a firewall monitor."
SRC_URI="http://firestarter.sf.net/beta/${P}beta1.tar.gz"
HOMEPAGE="http://firestarter.sf.net"
KEYWORDS="x86" 
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+
	gnome-base/libgnome	
	sys-apps/iptables
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86"

src_compile() {

	local myconf
	use nls \
           && myconf="${myconf} --enable-nls" \
		   || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	
	einstall destdir=${D} graphicsdir=${D}/usr/share/pixmaps || die "einstall failed"
	dodoc AUTHORS Changelog README TODO

}

pkg_postinstall() {
	./postinstall
}
