# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gqueue/gqueue-0.8.ebuild,v 1.3 2004/05/13 14:26:58 dholm Exp $

DESCRIPTION="Gnome frontend for cups queues. It shows the printing jobs queue and let you remove some jobs."
SRC_URI="http://web.tiscali.it/diegobazzanella/${P}.tar.gz"
HOMEPAGE="http://web.tiscali.it/diegobazzanella/"

S=${WORKDIR}/gqueue

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=net-print/cups-1.1.14
	>=gnome-base/libgnomeui-2.0.0"

src_install() {
	einstall || die
	dodoc AUTHORS COPYING
}
