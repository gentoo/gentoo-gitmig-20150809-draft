# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $

IUSE=""
DESCRIPTION="pal command-line calendar program"
SRC_URI="http://scott.kuhlweb.com/compu/pal/${P}.tgz"
HOMEPAGE="http://scott.kuhlweb.com/compu/pal/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}/src"

DEPEND=">=dev-libs/glib-2.0
	sys-devel/gettext
	virtual/glibc
	sys-libs/readline"

src_unpack() {
	unpack ${P}.tgz
	cd ${S}
	sed -i -e "s/-O2 -Wall/${CFLAGS}/" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install-no-rm || die "Install failed"
}

