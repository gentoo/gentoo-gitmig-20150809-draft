# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nomad/nomad-0.3.2.ebuild,v 1.2 2005/03/15 01:05:06 angusyoung Exp $

DESCRIPTION="Nomad is a network mapping program that uses SNMP to automatically discover a local network"
HOMEPAGE="http://netmon.ncl.ac.uk/"
SRC_URI="ftp://ftp.ncl.ac.uk/pub/local/npac/nomad-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=gnome-base/gconf-1*
	>=media-libs/gdk-pixbuf-0.10.1
	=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.14
	=gnome-base/libglade-0*
	>=gnome-base/gnome-libs-1*
	>=net-analyzer/net-snmp-5*
	net-analyzer/fping"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	einfo "Running nomad configuration tool"
	nomad-config-tool > /dev/null
	einfo "In order to run this software as a non-root user you'll"
	einfo "have to:"
	einfo "1) have fping in your \$PATH"
	einfo "2) configure fping as a suid executable by doing the"
	einfo "following command: chmod u+s /usr/sbin/fping"
}
