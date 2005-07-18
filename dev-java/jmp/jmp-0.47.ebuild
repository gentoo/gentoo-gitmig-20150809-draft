# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmp/jmp-0.47.ebuild,v 1.2 2005/07/18 16:08:49 axxo Exp $

DESCRIPTION="Java Memory Profiler"
HOMEPAGE="http://www.khelekore.org/jmp/"
SRC_URI="http://www.khelekore.org/jmp/${P}.tar.gz"
IUSE="gtk"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
RDEPEND=">=virtual/jre-1.3
		gtk? ( >=x11-libs/gtk+-2.0 )"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}"

src_compile() {
	local myconf=""
	use gtk || myconf="${myconf} --enable-noui"
	econf ${myconf} || die "econf ${myconf} failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"
	dodoc ChangeLog README
}
