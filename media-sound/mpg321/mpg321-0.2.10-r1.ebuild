# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.10-r1.ebuild,v 1.20 2004/07/12 08:04:38 eradicator Exp $

IUSE=""

DESCRIPTION="Free MP3 player, drop-in replacement for mpg123"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mpg321/"

DEPEND=">=media-sound/madplay-0.14.2b
	>=media-libs/libao-0.8.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86 ~ppc sparc mips alpha"

PROVIDE="virtual/mpg123"

src_compile() {
	# disabling the symlink here and doing it in postinst is better for GRP
	econf --disable-mpg123-symlink || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog HACKING INSTALL NEWS README README.remote THANKS TODO
}

pkg_postinst() {
	# We create a symlink for /usr/bin/mpg123 if it doesn't already exist
	if ! [ -f /usr/bin/mpg123 ]; then
		ln -s mpg321 /usr/bin/mpg123
	fi
}

pkg_postrm() {
	# We can't delete it here because it would break upgrades.
	if [ -L /usr/bin/mpg123 ]; then
		einfo "The /usr/bin/mpg123 symlink still exists.  You may wish to remove it."
	fi
}
