# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/tuxnes/tuxnes-0.75.ebuild,v 1.2 2003/01/31 21:52:22 mholzer Exp $

inherit flag-o-matic

S="${WORKDIR}/${P}"
DESCRIPTION="TuxNES is an emulator for the 8-bit Nintendo Entertainment System"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://tuxnes.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X ggi"
DEPEND=">=media-libs/netpbm-9.12
		X? ( virtual/x11 )
		ggi? ( >=media-libs/libggi-2.0.1 )"

src_unpack() {
	unpack ${A}

	echo ">>> Patching configure.in"
	patch ${S}/configure.in \
		${FILESDIR}/configure.in-${P}-gentoo.diff \
		&>/dev/null

	echo ">>> Running autoreconf"
	cd "${S}" && \
		autoreconf &>/dev/null
}

src_compile() {
	local config_opts

	# Breaks with higher optimization
	replace-flags "-O?" "-O"

	# Enable X support?
	[ "`use X`" ] \
		&& config_opts="--with-x" \
		|| config_opts="--without-x"

	# Enable GGI support?
	[ "`use ggi`" ] \
		&& config_opts="${config_opts} --with-ggi" \
		|| config_opts="${config_opts} --without-ggi"

	# Don't even bother checking for W windows
	econf --without-w ${config_opts}

	emake || die
}

src_install () {
	make DESTDIR=${D} \
		install \
		|| die

	# Install pixmaps
	dodir /usr/share/pixmaps
	insinto /usr/share/pixmaps
	doins tuxnes.xpm tuxnes2.xpm

	# Install documentation
	dodoc AUTHORS BUGS ChangeLog CHANGES \
		COPYING INSTALL NEWS README THANKS
}
