# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.0.ebuild,v 1.1 2005/03/27 02:09:48 matsuu Exp $

MY_P="tDOM-${PV}"
DESCRIPTION="XML manipulation library for TCL"
HOMEPAGE="http://www.tdom.org/"
SRC_URI="http://www.tdom.org/files/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="threads"

DEPEND=">=dev-lang/tcl-8.4.3"

S="${WORKDIR}/${MY_P}"


src_compile() {
	local myconf=""

	myconf="${myconf} --enable-shared `use_enable threads`"

	cd ${S}/unix
	ECONF_SOURCE=".." econf ${myconf} || die "failed to configure"
	emake || die "failed to compile tdom"

	# compile tdomhtml
	cd ${S}/extensions/tdomhtml
	econf || die "fail to configure tdomhtml"
	emake || die "fail to compile tdomhtml"

	# compile tnc
	cd ${S}/extensions/tnc
	econf ${myconf} || die "failed to configure tnc"
	emake || die "failed to compile tnc"
}

src_install() {
	cd ${S}/unix
	make DESTDIR=${D} install || die

	cd ${S}/extensions/tdomhtml
	make DESTDIR=${D} install || die

	cd ${S}/extensions/tnc
	make DESTDIR=${D} install || die

	cd ${S}
	dodoc CHANGES ChangeLog README*
}
