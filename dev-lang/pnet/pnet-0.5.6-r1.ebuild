# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pnet/pnet-0.5.6-r1.ebuild,v 1.1 2003/05/07 19:29:00 scandium Exp $

DESCRIPTION="Portable .NET runtime, compiler, tools"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-util/treecc-0.2.4"

src_compile() {
	# replace -march with -mcpu since -march=* breaks compile in cvm.c
	CFLAGS="${CFLAGS/-march/-mcpu}" \
	CXXFLAGS="${CXXFLAGS/-march/-mcpu}" \
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README 
	dodoc doc/gtk-sharp.HOWTO doc/*html
}
