# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xffm-icons/xffm-icons-4.0.0.ebuild,v 1.8 2003/12/19 01:18:24 weeve Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Icons for xffm"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ~ppc ~alpha sparc amd64 hppa"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	>=xfce-base/xffm-${PV}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
