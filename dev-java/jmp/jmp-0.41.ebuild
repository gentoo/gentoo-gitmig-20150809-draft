# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmp/jmp-0.41.ebuild,v 1.3 2004/07/02 04:21:57 eradicator Exp $

DESCRIPTION="Java Memory Profiler"
HOMEPAGE="http://www.khelekore.org/jmp/"
SRC_URI="http://www.khelekore.org/jmp/${P}.tar.gz"
IUSE="gtk"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/libc
		gtk? ( >=x11-libs/gtk+-2.0 )
		virtual/jdk"
RDEPEND="gtk? ( >=x11-libs/gtk+-2.0 )
		virtual/jre"
src_compile() {
	local myconf=""
	use gtk || myconf="${myconf} --enable-noui"
	econf ${myconf} || die "econf ${myconf} failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die "install failed"
	dodoc ChangeLog README
}
