# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/eleven/eleven-1.0.ebuild,v 1.1 2005/02/28 02:51:29 pclouds Exp $

DESCRIPTION="A programming language for creating robust, scalable Web applications quickly and easily."
HOMEPAGE="http://eleven.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-util/guile"
DEPEND="${RDEPEND} sys-devel/bison"
src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc install || die
}
