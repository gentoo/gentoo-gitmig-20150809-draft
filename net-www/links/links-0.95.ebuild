# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>

S=${WORKDIR}/links-0.95
SRC_URI="http://artax.karlin.mff.cuni.cz/~mikulas/links/download/links-0.95.tar.gz"

HOMEPAGE="http://artax.karlin.mff.cuni.cz/~mikulas/links"

DESCRIPTION="A links like console-based web browser"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/openssl-0.9.6"

src_compile() {

    try ./configure --prefix=/usr --enable-ssl
    try make

}


src_install() {

    try make DESTDIR=${D} install

    dodoc README SITES NEWS AUTHORS COPYING BUGS TODO

}
