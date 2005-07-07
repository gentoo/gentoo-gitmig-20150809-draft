# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.20.ebuild,v 1.1 2005/07/07 00:50:16 leonardop Exp $

inherit flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc ipv6 nls"

RDEPEND=">=dev-libs/boost-1.32"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	nls? ( >=sys-devel/gettext-0.12.1 )
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
	einfo
	einfo "If you are upgrading from:"
	einfo "  - 0.19 or earlier: there are some command line and server"
	einfo "    configuration changes; see /usr/share/doc/${PF}/NEWS.gz"
	einfo "  - 0.18 or earliear: if you have created a ~/.monotonerc, rename"
	einfo "    it to ~/.monotone/monotonerc, so monotone will still find it."
	einfo "  - 0.17: simply make a backup of your databases, just in case, and"
	einfo "    run \"db migrate\" on each."
	einfo
	einfo "For instructions to upgrade from previous versions, please read"
	einfo "/usr/share/doc/${PF}/UPGRADE.gz"
	einfo
	einfo "Also, please note that 0.19 clients cannot talk to 0.20 servers,"
	einfo "and vice-versa."
	einfo
}
