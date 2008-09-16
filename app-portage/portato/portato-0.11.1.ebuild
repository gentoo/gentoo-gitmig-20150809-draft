# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portato/portato-0.11.1.ebuild,v 1.1 2008/09/16 20:07:29 jokey Exp $

EAPI=1

NEED_PYTHON="2.5"
inherit python eutils distutils

DESCRIPTION="A GUI for Portage written in Python."
HOMEPAGE="http://portato.origo.ethz.ch/"
SRC_URI="http://download.origo.ethz.ch/portato/775/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde +libnotify nls userpriv"
LANGS="ca de pl tr"
for LANG in $LANGS; do IUSE="${IUSE} linguas_${LANG}"; done

RDEPEND="app-portage/portage-utils
		x11-libs/vte
		gnome-base/libglade
		dev-python/pygtksourceview:2
		>=dev-python/pygtk-2.12.0
		>=sys-apps/portage-2.1.2

		!userpriv? (
			dev-python/shm
			kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
			!kde? ( x11-libs/gksu ) )

		libnotify? ( dev-python/notify-python )
		nls? ( virtual/libintl )"

# only needs gettext as build dependency
# python should be set as DEPEND in the python-eclass
DEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}"
CONFIG_DIR="etc/${PN}"
DATA_DIR="usr/share/${PN}"
LOCALE_DIR="usr/share/locale"
PLUGIN_DIR="${DATA_DIR}/plugins"
ICON_DIR="${DATA_DIR}/icons"
TEMPLATE_DIR="${DATA_DIR}/templates"

pkg_setup ()
{
	if ! built_with_use x11-libs/vte python; then
		echo
		eerror "x11-libs/vte has not been built with python support."
		eerror "Please re-emerge vte with the python use-flag enabled."
		die "missing python flag for x11-libs/vte"
	fi
}

src_compile ()
{
	local su="\"gksu -D 'Portato'\""
	use kde && su="\"kdesu -t -d -i '%s' --nonewdcop -c\" % APP_ICON"

	sed -i 	-e "s;^\(VERSION\s*=\s*\).*;\1\"${PV}\";" \
			-e "s;^\(CONFIG_DIR\s*=\s*\).*;\1\"${ROOT}${CONFIG_DIR}/\";" \
			-e "s;^\(DATA_DIR\s*=\s*\).*;\1\"${ROOT}${DATA_DIR}/\";" \
			-e "s;^\(TEMPLATE_DIR\s*=\s*\).*;\1\"${ROOT}${TEMPLATE_DIR}/\";" \
			-e "s;^\(ICON_DIR\s*=\s*\).*;\1\"${ROOT}${ICON_DIR}/\";" \
			-e "s;^\(LOCALE_DIR\s*=\s*\).*;\1\"${ROOT}${LOCALE_DIR}/\";" \
			-e "s;^\(SU_COMMAND\s*=\s*\).*;\1$su;" \
			"${PN}"/constants.py || die "sed failed"

	if use userpriv; then
		sed -i -e "s/Exec=.*/Exec=portato --no-fork/" portato.desktop || die "sed failed"
	fi

	if use nls; then
		./pocompile.sh -emerge ${LINGUAS} || die "pocompile failed"
	fi

	distutils_src_compile
}

src_install ()
{
	dodir ${DATA_DIR} || die
	distutils_src_install

	newbin portato.py portato || die
	dodoc doc/*

	# config
	insinto ${CONFIG_DIR}
	doins etc/* || die

	# plugins
	insinto ${PLUGIN_DIR}

	# desktop
	doicon icons/portato-icon.png || die
	domenu portato.desktop || die

	# nls
	use nls && domo i18n/mo/*
}

pkg_postinst ()
{
	distutils_pkg_postinst
	python_mod_optimize "/${PLUGIN_DIR}"
}

pkg_postrm ()
{
	distutils_pkg_postrm
	python_mod_cleanup "/${PLUGIN_DIR}"

	# try to remove the DATA_DIR, because it may still reside there, as it was tried
	# to remove it before plugin stuff was purged
	rmdir "${ROOT}"${DATA_DIR} 2> /dev/null
}
