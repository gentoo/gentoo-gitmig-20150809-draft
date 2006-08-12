# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shmux/shmux-1.0_beta10.ebuild,v 1.1 2006/08/12 13:44:39 swegener Exp $

MY_P=${P/_beta/b}

DESCRIPTION="Program for executing the same command on many hosts in parallel"
HOMEPAGE="http://web.taranis.org/shmux/"
SRC_URI="http://web.taranis.org/${PN}/dist/${MY_P}.tgz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="pcre"

RDEPEND="pcre? ( dev-libs/libpcre )"
DEPEND="${RDEPEND}
	sys-apps/gawk"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_with pcre) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/shmux || die "dobin failed"
	doman shmux.1 || die "doman failed"
	dodoc CHANGES || die "dodoc failed"
}
