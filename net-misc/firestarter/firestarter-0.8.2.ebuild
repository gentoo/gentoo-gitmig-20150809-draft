# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $HEADER: $

#MY_P=firestarter-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="Gui for firewalls (iptables & ipchains), and a firewall
monitor."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/firestarter/firestarter-0.8.2.tar.gz"
HOMEPAGE="http://firestarter.sf.net"

LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2.10-r8
	>=gnome-base/gnome-libs-1.4.1.4
	sys-apps/iptables"
RDEPEND="${DEPEND}"
SLOT="0"

src_compile() {

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	
	einstall || die "einstall failed"
}

pkg_postinstall() {
	./postinstall
}
