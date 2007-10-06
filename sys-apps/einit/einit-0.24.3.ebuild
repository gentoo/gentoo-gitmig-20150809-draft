# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/einit/einit-0.24.3.ebuild,v 1.1 2007/10/06 13:27:38 vapier Exp $

inherit multilib

DESCRIPTION="an alternate /sbin/init"
HOMEPAGE="http://einit.org/"
SRC_URI="mirror://berlios/einit/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -r \
		-e "/(((|U)LIB|MOD)DIR|BOOTSTRAP_MODULE_PATH)/s:/lib/:/$(get_libdir)/:" \
		configure \
		|| die
}

src_compile() {
	econf \
		--enable-linux \
		--use-posix-regex \
		--prefix=/ \
		 || die
	emake || die
	if use doc ; then
		emake documentation-html ||die
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README NEWS TODO
	doman documentation/man/*
	if use doc ; then
		dohtml build/documentation/html/*.html
	fi
}

pkg_postinst() {
	einfo "You can always find the latest documentation at"
	einfo "http://einit.sourceforge.net/documentation/users/"
}
