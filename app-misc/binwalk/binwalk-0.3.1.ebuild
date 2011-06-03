# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/binwalk/binwalk-0.3.1.ebuild,v 1.2 2011/06/03 08:21:54 radhermit Exp $

EAPI=4

inherit eutils

DESCRIPTION="A tool for identifying files embedded inside firmware images"
HOMEPAGE="http://code.google.com/p/binwalk/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/file"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch \
		"${FILESDIR}"/${P}-ldflags.patch
}
