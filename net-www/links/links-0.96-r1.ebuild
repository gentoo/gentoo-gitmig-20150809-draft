# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/links/links-0.96-r1.ebuild,v 1.6 2002/08/16 03:01:01 murphy Exp $

S=${WORKDIR}/${P}
SRC_URI="http://artax.karlin.mff.cuni.cz/~mikulas/links/download/${P}.tar.gz"
HOMEPAGE="http://artax.karlin.mff.cuni.cz/~mikulas/links"
DESCRIPTION="A console-based web browser"
DEPEND=">=sys-libs/ncurses-5.1
	gpm? ( >=sys-libs/gpm-1.19.3 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	local myconf
	use ssl \
		&& myconf="--enable-ssl" \
		|| myconf="--disable-ssl"

	econf ${myconf} || die

	# links doesn't respect a --without-gpm option; 
	# the only way to fix it is to edit the 
	# 'config.h' file afterwads. Luckily for us, sed exists. ;)
	use gpm && ( \
		echo "Leaving LibGPM enabled."
    ) || ( \
		echo "Disabling LibGPM."
		cat config.h | sed 's/.*LIBGPM 1/#undef HAVE_LIBGPM/g' > tmp~
		mv tmp~ config.h
	)
	emake || die
}


src_install() {
    make DESTDIR=${D} install || die
    dodoc README SITES NEWS AUTHORS COPYING BUGS TODO Changelog
}
