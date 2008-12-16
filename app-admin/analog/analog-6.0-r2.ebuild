# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-6.0-r2.ebuild,v 1.4 2008/12/16 15:25:19 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A webserver log analyzer"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/gd-1.8.4-r2
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"

pkg_setup() {
	if ! built_with_use media-libs/gd jpeg ; then
		eerror "libgd is missing jpeg support. Please add"
		eerror "'jpeg' to your USE flags, and re-emerge media-libs/gd."
		die "libgd needs jpeg support"
	fi
	if ! built_with_use media-libs/gd png ; then
		eerror "libgd is missing jpeg support. Please add"
		eerror "'png' to your USE flags, and re-emerge media-libs/gd."
		die "libgd needs png support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	epatch "${FILESDIR}/${PN}-5.1-gentoo.diff"
	epatch "${FILESDIR}/${P}-bzip2.patch"
}

src_compile() {
	tc-export CC
	emake || die "make failed"
}

src_install() {
	dobin analog || die "dobin failed"
	newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg
	dohtml -a html,gif,css,ico docs/*
	dohtml -r how-to
	docinto examples ; dodoc examples/*
	docinto cgi ; dodoc anlgform.pl

	insinto /usr/share/analog/images ; doins images/*
	insinto /usr/share/analog/lang ; doins lang/*
	dodir /var/log/analog
	dosym /usr/share/analog/images /var/log/analog/images
	insinto /etc/analog ; doins "${FILESDIR}/analog.cfg"
}
