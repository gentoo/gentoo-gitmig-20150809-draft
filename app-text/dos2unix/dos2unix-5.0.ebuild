# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dos2unix/dos2unix-5.0.ebuild,v 1.1 2010/03/20 16:07:47 jlec Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Convert DOS or MAC text files to UNIX format or vice versa"
HOMEPAGE="http://www.xs4all.nl/~waterlan/ http://sourceforge.net/projects/dos2unix/"
SRC_URI="
	http://www.xs4all.nl/~waterlan/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="nls"

RDEPEND="
	!app-text/hd2u
	!app-text/unix2dos"

src_prepare() {
	sed \
		-e '/^LDFLAGS/s|=|+=|' \
		-e '/^CC/s|=|?=|' \
		-i "${S}"/Makefile
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" $(use nls || echo "ENABLE_NLS=") install \
		|| die "emake install failed"
}
