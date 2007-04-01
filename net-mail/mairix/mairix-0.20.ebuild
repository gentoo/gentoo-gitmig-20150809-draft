# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mairix/mairix-0.20.ebuild,v 1.1 2007/04/01 20:58:55 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="Indexes and searches Maildir/MH folders"
HOMEPAGE="http://www.rpcurnow.force9.co.uk/mairix/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"

IUSE="zlib bzip2"

RDEPEND="zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_unpack() {
	unpack ${A}

	# econf would fail with unknown options.
	# Now it only prints "Unrecognized option".
	sed -i -e "/^[[:space:]]*bad_options=yes/d" "${S}"/configure || die "sed failed"
}

src_compile() {
	export CC="$(tc-getCC)"
	econf \
		$(use_enable zlib gzip-mbox) \
		$(use_enable bzip2 bzip-mbox) || die "configure failed."

	emake  all || die "make failed."
}

src_install() {
	dobin mairix || die "dobin failed"
	doman mairix.1 mairixrc.5 || die "doman failed"
	dodoc NEWS README dotmairixrc.eg || die "dodoc failed"
}
