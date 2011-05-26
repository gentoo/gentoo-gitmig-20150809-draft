# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlongrun/wmlongrun-0.2.0.ebuild,v 1.8 2011/05/26 13:42:19 s4t4n Exp $

DESCRIPTION="A dockapp to monitor LongRun on a Transmeta Crusoe processor"
HOMEPAGE="http://www.dockapps.org/file.php/id/38"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

# Since this will only work with a Crusoe processor, it's safe to assume that
# the functionality is only available on x86.
KEYWORDS="x86 -*"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS TODO MAKEDEV-cpuid-msr
}
