# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-0.1.1.ebuild,v 1.1 2009/05/25 21:00:09 pva Exp $

# Do not remove this ebuild until sysload depends on it.
inherit versionator

MY_P=${PN}-$(replace_version_separator 2 '')
DESCRIPTION="access a working SSH implementation by means of a library"
HOMEPAGE="http://0xbadc0de.be/?part=libssh"
SRC_URI="http://www.0xbadc0de.be/libssh/${MY_P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~s390 x86"
IUSE=""

DEPEND="sys-libs/zlib
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	emake prefix="${D}/usr" install || die "make install failed"
	chmod a-x "${D}"/usr/include/libssh/*
}
