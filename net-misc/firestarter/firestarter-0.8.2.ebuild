# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/firestarter/firestarter-0.8.2.ebuild,v 1.9 2002/08/14 12:08:07 murphy Exp $

#MY_P=firestarter-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="Gui for firewalls (iptables & ipchains), and a firewall monitor."
SRC_URI="mirror://sourceforge/firestarter/${P}.tar.gz"
HOMEPAGE="http://firestarter.sf.net"
KEYWORDS="x86 sparc sparc64" 
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.4
	sys-apps/iptables"
RDEPEND="nls? ( sys-devel/gettext )"
SLOT="0"

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
