# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xac/xac-0.6_pre1.ebuild,v 1.1 2007/01/03 02:38:36 josejx Exp $

inherit toolchain-funcs

DESCRIPTION="Xorgautoconfig (xac) generates configuration files for X.org"
HOMEPAGE="http://dev.gentoo.org/~josejx/xac.html"
LICENSE="GPL-2"
KEYWORDS="~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/python-2.3
	   sys-apps/pciutils"
RDEPEND=">=dev-lang/python-2.3
		 || ( x11-base/xorg-server virtual/x11 )"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

src_compile() {
	### Replace /usr/lib/xac with libdir version 
	cd "${S}"
	sed -i "s:/usr/lib/xac:/usr/$(get_libdir)/xac:" xac

	### Compile the C bindings
	cd "${S}"/src
	### I'm not sure of a better way to do this yet
	if use x86 || use amd64; then
		sed -i "s:if 1:if 0:" setup.py || die "Enabling VBE module failed!"
	fi
	./setup.py build || die "Failed to build the C modules"
}

src_install() {
	local xac_base="/usr/$(get_libdir)/xac"

	dosbin "${S}"/xac

	### Install the C mods
	cd "${S}"/src
	./setup.py install --root "${D}" || die "Failed to install the C modules"

	dodir "${xac_base}"
	insinto ${xac_base}
	doins "${S}"/py/*

	exeinto /etc/init.d
	newexe "${S}"/xac.init xac
	insinto /etc/conf.d
	newins "${S}"/xac.conf xac
}
