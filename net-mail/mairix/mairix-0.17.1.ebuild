# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mairix/mairix-0.17.1.ebuild,v 1.1 2006/01/09 09:43:09 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="Indexes and searches Maildir/MH folders"
HOMEPAGE="http://www.rpcurnow.force9.co.uk/mairix/"
SRC_URI="http://www.rpcurnow.force9.co.uk/mairix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	>=sys-apps/texinfo-4.2"

src_unpack() {
	unpack ${A}

	# econf would fail with unknown options.
	# Now it only prints "Unrecognized option".
	sed -i -e "/^[[:space:]]*bad_options=yes/d" "${S}"/configure || die "sed failed."
}

src_compile() {
	export CC="$(tc-getCC)"
	econf || die "configure failed."

	emake all mairix.info || die "make failed."
}

src_install() {
	dobin mairix || die "dobin failed"
	doinfo mairix.info
	dodoc NEWS README mairix.txt
}
