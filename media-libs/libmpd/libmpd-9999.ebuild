# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-9999.ebuild,v 1.1 2011/07/17 16:02:10 angelos Exp $

EAPI=4
inherit autotools git-2

DESCRIPTION="A library handling connections to a MPD server"
HOMEPAGE="http://gmpc.wikia.com/wiki/Libmpd"
EGIT_REPO_URI="git://git.musicpd.org/master/${PN}.git"
EGIT_BOOTSTRAP="eautoreconf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc static-libs"

RDEPEND=">=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_compile() {
	emake
	use doc && emake -C doc doc
}

src_install() {
	default
	use doc && dohtml -r doc/html/*
	find "${ED}" -name "*.la" -exec rm -rf {} + || die
	rm "${ED}"/usr/share/doc/${PF}/{README,ChangeLog} || die
}
