# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbacpi/bbacpi-0.1.3.ebuild,v 1.2 2005/07/16 17:21:05 smithj Exp $

DESCRIPTION="ACPI monitor for X11"
SRC_URI="mirror://sourceforge/bbacpi/${P}.tar.gz"
HOMEPAGE="http://bbacpi.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/x11
	virtual/blackbox
	>=x11-libs/gtk+-2.4.9-r1
	>=media-libs/imlib-1.9.14-r3
	>=x11-misc/xdialog-2.1.1
	sys-power/acpi
	sys-power/acpid"

src_install () {
	einstall || die "install failed"
	dodoc README COPYING AUTHORS BUGS ChangeLog TODO
}
