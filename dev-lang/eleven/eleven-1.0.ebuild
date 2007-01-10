# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/eleven/eleven-1.0.ebuild,v 1.3 2007/01/10 17:50:58 hkbst Exp $

DESCRIPTION="A programming language for creating robust, scalable Web applications quickly and easily."
HOMEPAGE="http://eleven.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND} sys-devel/bison"
src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc install || die
}
