# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/einit/einit-0.21.0.ebuild,v 1.1 2007/04/01 22:44:15 vapier Exp $

inherit multilib

DESCRIPTION="an alternate /sbin/init"
HOMEPAGE="http://einit.sourceforge.net/"
SRC_URI="mirror://sourceforge/einit/${P}.tar.bz2"

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
	sed -i -e "/MODDIR/s:/lib/:/$(get_libdir)/:" configure
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
	dodoc AUTHORS ChangeLog
	doman documentation/man/*
	if use doc ; then
		dohtml build/documentation/html/*.html
	fi
}

pkg_postinst() {
	einfo "You can always find the latest documentation at"
	einfo "http://einit.sourceforge.net/documentation/users/"
}
