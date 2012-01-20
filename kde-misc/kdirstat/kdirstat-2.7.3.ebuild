# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdirstat/kdirstat-2.7.3.ebuild,v 1.1 2012/01/20 22:58:44 dilfridge Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Nice KDE replacement to the du command"
HOMEPAGE="https://bitbucket.org/jeromerobert/k4dirstat/"
SRC_URI="${HOMEPAGE}get/k4dirstat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="kde-base/libkonq:4
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_unpack() {
	# tarball contains git revision hash, which we don't want in the ebuild.
	default
	mv "${WORKDIR}"/*k4dirstat-* "${S}" || die
}
