# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmget/wmget-0.4.4.ebuild,v 1.6 2004/03/19 10:04:28 aliz Exp $

inherit eutils

S="${WORKDIR}/wmget"

DESCRIPTION="libcurl-based dockapp for automated-downloads"
HOMEPAGE="http://amtrickey.net/wmget/"
SRC_URI="http://amtrickey.net/download/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11
	>=net-ftp/curl-7.9.7"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/makefile.diff
}

src_compile() {

	emake || die "parallel make failed"

}

src_install() {

	make PREFIX=${D}/usr install || die "make install failed"

}
