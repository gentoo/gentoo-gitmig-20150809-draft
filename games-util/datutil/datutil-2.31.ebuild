# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/datutil/datutil-2.31.ebuild,v 1.3 2008/10/29 11:51:12 flameeyes Exp $

inherit toolchain-funcs

DL_PV=2.20
DESCRIPTION="Converter for dat files for Rom Managers"
HOMEPAGE="http://www.logiqx.com/Tools/DatUtil/"
SRC_URI="http://www.logiqx.com/Tools/DatUtil/dutil${PV//.}.zip
	http://www.logiqx.com/Tools/DatLib/datlib${DL_PV//.}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack dutil${PV//.}.zip
	mkdir -p "${S}"/dev/datlib && cd "${S}"/dev/datlib
	unpack datlib${DL_PV//.}.zip
}

src_compile() {
	# Parallel make issue, see bug #244879
	emake -j1 CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@# || die "emake failed"
}

src_install() {
	dobin datutil || die "cannot install datutil"
	dodoc readme.txt whatsnew.txt
}
