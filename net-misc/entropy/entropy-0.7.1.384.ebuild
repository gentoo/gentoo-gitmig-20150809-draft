# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/entropy/entropy-0.7.1.384.ebuild,v 1.3 2004/07/15 02:48:30 agriffis Exp $

MY_PV_BUILD=${PV/*.}
MY_PV=${PV/.${MY_PV_BUILD}}
DESCRIPTION="Emerging Network To Reduce Orwellian Potency Yield"
HOMEPAGE="http://entropy.stop1984.com/"
SRC_URI="http://entropy.stop1984.com/files/entropy-${MY_PV}-${MY_PV_BUILD}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql"

DEPEND="sys-libs/zlib
	dev-libs/expat
	mysql? ( dev-db/mysql )"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local myconf=""
	use mysql && myconf="--with-mysql=/usr"
	econf ${myconf} || die
	emake || die
}

src_install() {
	dobin entropy
	dodoc README TODO entropy.conf-dist seed.txt-dist
	dohtml ENTROPY.html
	use mysql && dodoc README.MySQL
}

pkg_postinst() {
	einfo "You might want to check out the example conf and seed"
	einfo "files found in /usr/share/doc/${PF}/"
}
