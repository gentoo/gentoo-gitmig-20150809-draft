# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.0-r1.ebuild,v 1.1 2006/09/22 07:15:43 matsuu Exp $

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

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e "s/relid'/relid/" configure* tclconfig/tcl.m4 \
		extensions/tnc/configure extensions/example/{configure,tcl.m4} || die
}

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
	cd "${S}"/unix
	emake DESTDIR="${D}" install || die

	cd "${S}"/extensions/tdomhtml
	emake DESTDIR="${D}" install || die

	cd "${S}"/extensions/tnc
	emake DESTDIR="${D}" install || die

	cd "${S}"
	dodoc CHANGES ChangeLog README*
}
