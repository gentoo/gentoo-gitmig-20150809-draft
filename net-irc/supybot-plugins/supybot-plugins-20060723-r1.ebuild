# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot-plugins/supybot-plugins-20060723-r1.ebuild,v 1.1 2009/05/22 19:45:29 lack Exp $

inherit python multilib

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
RDEPEND=">=net-irc/supybot-0.83.4"

src_install() {
	cd "${WORKDIR}"/${MY_P}
	python_version
	PLUGIN_BASE="/usr/$(get_libdir)/python${PYVER}/site-packages/supybot/plugins"
	for plugin in *; do
		case $plugin in
			BadWords|Dunno|Success)
				# These plugins are part of supybot-0.83.4 now, so skip them
				# here.
				continue
				;;
			*)
			;;
		esac
		insinto ${PLUGIN_BASE}/${plugin}
		doins $plugin/* || die "Install failed"
	done
}

pkg_postinst() {
	python_version
	python_mod_optimize	/usr/$(get_libdir)/python${PYVER}/site-packages/supybot/plugins
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/supybot/plugins
}
