# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.4.ebuild,v 1.2 2002/10/24 04:59:19 raker Exp $

DESCRIPTION="library for bible reading software"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="ftp://ftp.crosswire.org/pub/sword/source/v1.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${P}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}

pkg_postinst() {

	einfo ""
	einfo "Check out http://www.crosswire.org/sword/modules/"
	einfo "to download modules that you would like to enhance"
	einfo "the library with.  unzip the files you download"
	einfo "while you are in the /usr/share/sword directory"
	einfo ""

}
