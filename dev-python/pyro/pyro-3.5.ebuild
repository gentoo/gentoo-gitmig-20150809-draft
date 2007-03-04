# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.5.ebuild,v 1.3 2007/03/04 09:50:06 lucass Exp $

inherit distutils eutils

MY_P="Pyro-${PV}"
DESCRIPTION="advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://pyro.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyro/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc examples"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.4-unattend.patch
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	if use doc; then
		dohtml -r docs/*
	fi

	mv "${D}"/usr/bin/esd "${D}"/usr/bin/pyroesd
}

pkg_postinst() {
	elog "Pyro's Event Service Daemon, /usr/bin/esd has been renamed to"
	elog " /usr/bin/pyroesd to avoid conflict with media-sound/esound."
}
