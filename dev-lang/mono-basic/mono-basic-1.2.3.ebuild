# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono-basic/mono-basic-1.2.3.ebuild,v 1.1 2007/02/11 07:53:52 compnerd Exp $

inherit mono multilib

DESCRIPTION="Visual Basic .NET Runtime and Class Libraries"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://go-mono.com/sources/${PN}/${PN}-${PV}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.2.2.1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s|\(mono_libdir=\${exec_prefix}\)/lib|\1/$(get_libdir)|" \
		configure || die "sed failed"
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
