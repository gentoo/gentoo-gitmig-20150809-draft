# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-9999.ebuild,v 1.1 2012/02/20 19:00:47 jdhore Exp $

EAPI=4

inherit git-2

MY_P=${P/_/-}

DESCRIPTION="Useful set of performance and usability-oriented extensions to C"
HOMEPAGE="http://www.atheme.org/project/mowgli"
EGIT_REPO_URI="git://git.atheme.org/libmowgli-2.git"
IUSE="ssl"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS=""
RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable ssl openssl)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README doc/BOOST
}
