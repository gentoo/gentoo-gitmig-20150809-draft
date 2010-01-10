# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jless/jless-382.262.ebuild,v 1.2 2010/01/10 17:55:17 ulm Exp $

inherit autotools eutils

LESS_P="less-${PV%%.*}"

DESCRIPTION="Jam less is an enhancement of less which supports multibyte character"
HOMEPAGE="http://www25.big.jp/~jam/less/"
JAM_URI="http://www25.big.jp/~jam/less"
SRC_URI="mirror://gnu/less/${LESS_P}.tar.gz
	${JAM_URI}/${LESS_P}-iso258.patch.gz
	${JAM_URI}/${LESS_P}-iso258-259.patch.gz
	${JAM_URI}/${LESS_P}-iso259-260.patch.gz
	${JAM_URI}/${LESS_P}-iso260-261.patch.gz
	${JAM_URI}/${LESS_P}-iso261-262.patch.gz"

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

S="${WORKDIR}/${LESS_P}"

src_unpack() {
	unpack ${LESS_P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}/${LESS_P}-iso258.patch.gz"
	epatch "${DISTDIR}/${LESS_P}-iso258-259.patch.gz"
	epatch "${DISTDIR}/${LESS_P}-iso259-260.patch.gz"
	epatch "${DISTDIR}/${LESS_P}-iso260-261.patch.gz"
	epatch "${DISTDIR}/${LESS_P}-iso261-262.patch.gz"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_compile() {
	econf --without-cs-regex --with-editor="${EDITOR}" || die
	emake || die
}

src_install() {
	einstall binprefix=j manprefix=j || die

	newbin "${FILESDIR}/lesspipe.sh-r1" jlesspipe.sh || die
	doenvd "${FILESDIR}/70jless" || die

	dodoc NEWS README*
}
