# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.19.ebuild,v 1.2 2005/06/15 20:37:32 leonardop Exp $

inherit flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

IUSE="doc ipv6 nls"

RDEPEND=">=dev-libs/boost-1.31"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	sys-devel/gettext
	doc? ( sys-apps/texinfo )"

src_compile() {
	local myconf="$(use_enable nls) $(use_enable ipv6)"

	# more aggressive optimizations cause trouble with the crypto library
	strip-flags
	append-flags -fno-stack-protector-all -fno-stack-protector \
		-fno-strict-aliasing

	econf ${myconf} || die
	emake || die "emake failed"
	use doc && make html
}

src_test() {
	make check || die "self test failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	if use doc
	then
		dohtml -r html/*
		dohtml -r figures
	fi

	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README* UPGRADE
}

pkg_postinst() {
	ewarn "If you are upgrading from:"
	ewarn "  - 0.18: if you have created a ~/.monotonerc, rename it to"
	ewarn "          ~/.monotone/monotonerc, so monotone will still find it."
	ewarn "  - 0.17: simply make a backup of your databases, just in case, and"
	ewarn "          run \"db migrate\" on each."
	ewarn ""
	ewarn "For instructions to upgrade from previous versions, please read"
	ewarn "/usr/share/doc/${P}/UPGRADE.gz"
}
