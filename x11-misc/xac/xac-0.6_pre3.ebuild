# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xac/xac-0.6_pre3.ebuild,v 1.6 2009/05/05 18:18:34 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="Xorgautoconfig (xac) generates configuration files for X.org"
HOMEPAGE="http://dev.gentoo.org/~josejx/xac.html"
LICENSE="GPL-2"
KEYWORDS="ppc ppc64 ~x86"
SLOT="0"
IUSE="livecd"
DEPEND=">=dev-lang/python-2.3
	   sys-apps/pciutils"
RDEPEND=">=dev-lang/python-2.3
		x11-base/xorg-server"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	### Replace /usr/lib/xac with libdir version
	sed -i "s:/usr/lib/xac:/usr/$(get_libdir)/xac:" xac
}

src_compile() {
	### Compile the C bindings
	cd "${S}"/src
	### I'm not sure of a better way to do this yet
	if use x86; then
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

	### Only install the init scripts if livecd is enabled
	if use livecd; then
		newinitd "${S}"/xac.init xac
		newconfd "${S}"/xac.conf xac
	fi
}
