# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tn5250/tn5250-0.17.3.ebuild,v 1.2 2007/07/12 15:26:30 gustavoz Exp $

inherit eutils

DESCRIPTION="Telnet client for the IBM AS/400 that emulates 5250 terminals and printers."
HOMEPAGE="http://tn5250.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X ssl slang"

RDEPEND="sys-libs/ncurses
	ssl? ( dev-libs/openssl )
	slang? ( =sys-libs/slang-1* )"
DEPEND="${RDEPEND}
	X? ( || ( x11-libs/libXt virtual/x11 ) )"

src_unpack() {
	unpack ${A}

	# First, for some reason, TRUE and FALSE aren't defined
	# for the compile.	This causes some problems.	???
	echo							   >> "${S}/src/tn5250-config.h.in"
	echo "/* Define TRUE and FALSE */" >> "${S}/src/tn5250-config.h.in"
	echo "#define FALSE 0"			   >> "${S}/src/tn5250-config.h.in"
	echo "#define TRUE !FALSE"		   >> "${S}/src/tn5250-config.h.in"

	# Next, the Makefile for the terminfo settings tries to remove
	# some files it doesn't have access to.	 We can just remove those
	# lines.
	cd "${S}/linux"
	sed -i \
		-e "/rm -f \/usr\/.*\/terminfo.*5250/d" Makefile.in \
		|| die "sed Makefile.in failed"
	cd "${S}/src"
}

src_compile() {
	econf \
		$(use_with X x) \
		$(use_with ssl) \
		$(use_with slang) || die
	emake || die "emake failed"
}

src_install() {
	# The TERMINFO variable needs to be defined for the install
	# to work, because the install calls "tic."	 man tic for
	# details.
	dodir /usr/share/terminfo
	make DESTDIR="${D}" \
		 TERMINFO="${D}/usr/share/terminfo" install \
		 || die "make install failed"
	dodoc AUTHORS BUGS NEWS README README.ssl TODO
	dohtml -r doc/*
}
