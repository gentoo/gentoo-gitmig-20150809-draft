# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/litestream/litestream-1.3_rc3.ebuild,v 1.4 2007/08/11 17:41:22 armin76 Exp $

IUSE=""

inherit eutils flag-o-matic toolchain-funcs

MY_P="${P/_rc/RC}"

DESCRIPTION="Litstream is a lightweight and robust shoutcast-compatible streaming mp3 server."
HOMEPAGE="http://www.litestream.org/"
SRC_URI="http://litestream.org/litestream/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
# -amd64: 1.2 build errors - eradicator
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	sed -i -e 's:CFLAGS = :CFLAGS = ${OPTFLAGS} :; s:-g::' \
		${S}/Makefile
}

src_compile() {
	append-flags "-DNO_VARARGS"

	emake CC=$(tc-getCC) OPTFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin litestream literestream
	newbin source litestream-source
	newbin server litestream-server
	newbin client litestream-client

	dodoc ABOUT ACKNOWLEDGEMENTS BUGS CHANGELOG CONTACT FILES MAKEITGO README
}
