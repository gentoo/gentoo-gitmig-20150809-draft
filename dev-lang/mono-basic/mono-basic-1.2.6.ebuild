# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono-basic/mono-basic-1.2.6.ebuild,v 1.2 2010/02/11 15:15:51 ulm Exp $

inherit mono multilib

DESCRIPTION="Visual Basic .NET Runtime and Class Libraries"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-lang/mono-${PV}*"
DEPEND="${RDEPEND}"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s|\(mono_libdir=\${exec_prefix}\)/lib|\1/$(get_libdir)|" \
		configure || die "sed failed"
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
