# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/smixer/smixer-1.0.4.ebuild,v 1.2 2011/12/02 04:27:11 radhermit Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="command-line tool for setting and viewing mixer settings"
HOMEPAGE="http://centerclick.org/programs/smixer"
SRC_URI="http://centerclick.org/programs/${PN}/${PN}${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~amd64 ~sparc"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}"
}

src_install () {
	insinto /etc
	doins smixer.conf
	dobin smixer
	doman man/smixer.1
	dodoc README
}
