# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shared-mime-info/shared-mime-info-0.7.ebuild,v 1.3 2003/02/13 17:17:26 vapier Exp $

DESCRIPTION="The Shared MIME-info Database specification."
HOMEPAGE="http://www.freedesktop.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

DEPEND=">=sys-apps/gawk-3.1.0"

SRC_URI="http://www.freedesktop.org/standards/shared-mime-info/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
}

src_install () {
	make DESTDIR=${D} install || die
}
