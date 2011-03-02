# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/cgisysinfo/cgisysinfo-0.1.ebuild,v 1.1 2011/03/02 02:04:25 rafaelmartins Exp $

EAPI="4"

if [[ ${PV} = *9999* ]]; then
	WANT_AUTOCONF="2.5"
	WANT_AUTOMAKE="1.10"
	inherit autotools mercurial
	EHG_REPO_URI="http://hg.rafaelmartins.eng.br/cgisysinfo/"
	KEYWORDS=""
else
	SRC_URI="http://files.rafaelmartins.eng.br/distfiles/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A small cgi utility to show basic system information."
HOMEPAGE="http://labs.rafaelmartins.org/wiki/cgisysinfo"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DOCS="README AUTHORS NEWS"

src_prepare() {
	[[ ${PV} = *9999* ]] && eautoreconf
}

pkg_postinst() {
	elog "Please read the README file for usage info."
}
