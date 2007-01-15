# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nsis/nsis-2.23.ebuild,v 1.1 2007/01/15 12:39:37 mrness Exp $

inherit eutils

DESCRIPTION="Nullsoft Scriptable Install System"
HOMEPAGE="http://nsis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.93"

S="${WORKDIR}"/${P}-src

pkg_setup() {
	if ! has_version cross-mingw32/gcc; then
		eerror "Before you could emerge nsis, you need to install mingw32."
		eerror "Run the following command:"
		eerror "  emerge crossdev && crossdev mingw32"
		die "cross-mingw32/gcc is needed"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-config.patch
}

src_compile() {
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" \
		PREFIX_DEST="${D}" SKIPPLUGINS=System || die "scons failed"
}

src_install() {
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" \
		PREFIX_DEST="${D}" SKIPPLUGINS=System install || die "scons install failed"
	fperms -R go-w,a-x,a+X /usr/share/${PN}/ /usr/share/doc/${P}/ /etc/nsisconf.nsh
}
