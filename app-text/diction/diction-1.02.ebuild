# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Diction and style checkers for english and german texts."
SRC_URI="http://ftp.gnu.org/gnu/diction/diction-1.02.tar.gz"
HOMEPAGE="http://www.fsf.org/software/diction/diction.html"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="sys-devel/gettext"

src_compile() {
    ./configure --prefix=/usr ||die
    emake || die

}

src_install () {
    make prefix=${D}/usr install
}
