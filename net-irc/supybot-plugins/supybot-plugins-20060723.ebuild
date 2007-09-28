# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot-plugins/supybot-plugins-20060723.ebuild,v 1.2 2007/09/28 07:19:20 mr_bones_ Exp $

inherit python

MY_PNAME="Supybot-plugins"
MY_P="${MY_PNAME}-${PV}"

DESCRIPTION="Official set of extra plugins for Supybot"
HOMEPAGE="http://supybot.com"
SRC_URI="mirror://sourceforge/supybot/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="net-irc/supybot"

src_install() {
	cd "${WORKDIR}"/${MY_P}
	python_version
	PLUGIN_BASE="/usr/$(get_libdir)/python${PYVER}/site-packages/supybot/plugins"
	for plugin in *; do
		insinto ${PLUGIN_BASE}/${plugin}
		doins $plugin/* || die "Install failed"
	done
}

pkg_postinst() {
	python_mod_optimize	"${ROOT}"usr/$(get_libdir)/python*/site-packages/supybot/plugins
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"usr/$(get_libdir)/python*/site-packages/supybot/plugins
}
