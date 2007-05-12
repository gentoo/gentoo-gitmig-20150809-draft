# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/datutil/datutil-2.31.ebuild,v 1.2 2007/05/12 17:57:28 drizzt Exp $

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
	emake CC="$(tc-getCC)" LD="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" \
	CFLAGS="${CFLAGS} -Idev" LOGIQX=. EXT= UPX=@#
}

src_install() {
	dobin datutil || die "cannot install datutil"
	dodoc readme.txt whatsnew.txt
}
