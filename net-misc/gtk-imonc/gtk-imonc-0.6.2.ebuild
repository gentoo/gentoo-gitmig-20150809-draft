# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtk-imonc/gtk-imonc-0.6.2.ebuild,v 1.3 2004/07/01 21:05:15 squinky86 Exp $

DESCRIPTION="A GTK+-2 based imond client for fli4l"
SRC_URI="http://userpage.fu-berlin.de/~zeank/gtk-imonc/download/${P}${V}.tar.gz"
HOMEPAGE="http://userpage.fu-berlin.de/~zeank/gtk-imonc/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.2.1
	virtual/libc
	virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
}

