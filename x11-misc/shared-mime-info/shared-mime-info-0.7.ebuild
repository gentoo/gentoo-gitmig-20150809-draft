# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shared-mime-info/shared-mime-info-0.7.ebuild,v 1.4 2003/03/27 02:36:45 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Shared MIME-info Database specification."
HOMEPAGE="http://www.freedesktop.org"
SRC_URI="http://www.freedesktop.org/standards/shared-mime-info/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"

DEPEND=">=sys-apps/gawk-3.1.0"

src_install () {
	make DESTDIR=${D} install || die
}
