# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/socat/socat-1.3.0.1.ebuild,v 1.8 2005/03/21 23:10:18 chriswhite Exp $

DESCRIPTION="Multipurpose relay (SOcket CAT)"
HOMEPAGE="http://www.dest-unreach.org/socat/"
SRC_URI="http://www.dest-unreach.org/${PN}/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"

IUSE="ssl readline ipv6"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
	virtual/libc"
RDEPEND="virtual/libc"

S="${WORKDIR}/socat-1.3"

src_compile() {

	# Construct the config options for the optional features.
	local myconf
	use ssl || myconf="--disable-openssl"
	use readline || myconf="${myconf} --disable-readline"
	use ipv6 || myconf="${myconf} --disable-ip6"

	mv Makefile.in Makefile.in.org
	einfo "Sed"
	sed -e "s:-Wall:${CFLAGS} -Wall:" Makefile.in.org > Makefile.in
	einfo "Sed fertgi"
	econf ${myconf} || die "econf failed"

	# Calculating dependencies
	# (this seems to error out (due to gcc3?) but compiles work
	#  nonetheless)
	make depend

	# Starting the compile
	emake || die
}

src_install() {
	# The original install target is a bit broken when installing
	# into temporary roots.

	# The docs.
	dodoc BUGREPORTS CHANGES COPYING* DEVELOPMENT
	dodoc EXAMPLES FAQ FILES PORTING README
	dodoc SECURITY VERSION
	dodoc xio.help

	# The example scripts
	dodoc daemon.sh ftp.sh mail.sh

	# The html docs
	dohtml socat.html

	# The manpage
	doman socat.1

	# And the executables
	exeinto /usr/bin
	doexe socat
	doexe procan
	doexe filan
}

