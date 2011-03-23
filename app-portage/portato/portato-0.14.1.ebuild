# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portato/portato-0.14.1.ebuild,v 1.3 2011/03/23 06:15:24 ssuominen Exp $

EAPI="3"

inherit distutils eutils

DESCRIPTION="A GUI for Portage written in Python"
HOMEPAGE="http://necoro.eu/portato"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="eix kde libnotify nls +sqlite userpriv"
LANGS="ca de es fr it pl pt_BR tr"
for X in $LANGS; do IUSE="${IUSE} linguas_${X}"; done

COMMON_DEPEND="|| (
	dev-lang/python:2.7[sqlite?,threads]
	dev-lang/python:2.6[sqlite?,threads] )"

RDEPEND="$COMMON_DEPEND
	app-portage/portage-utils
	x11-libs/vte:0[python]
	>=dev-python/pygtk-2.14.0
	dev-python/pygtksourceview:2
	>=sys-apps/portage-2.1.7.17

	kde? ( kde-base/kdesu )
	!kde? ( || ( x11-misc/ktsuss x11-libs/gksu ) )
	libnotify? ( dev-python/notify-python )
	nls? ( virtual/libintl )
	eix? ( >=app-portage/eix-0.15.4 )"

DEPEND="$COMMON_DEPEND
	nls? ( sys-devel/gettext )"

# filled later on
PLUGIN_DIR=""

pkg_setup()
{
	python_set_active_version 2

	if use eix && ! use sqlite; then
		ewarn "You have enabled 'eix' but not 'sqlite'!"
		ewarn "eix-support depends on sqlite, so it will be disabled as well."
	fi
}

src_configure ()
{
	# set this before changing ROOT_DIR
	# else it would include $ROOT -- which would be plusungood
	PLUGIN_DIR=$(./portato.py --plugin-dir)

	sed -i -e "s;^\(ROOT_DIR\s*=\s*\).*;\1\"${ROOT}\";" portato/constants.py || die "sed failed"

	if use userpriv; then
		sed -i -e "s/Exec=.*/Exec=portato --no-fork/" portato.desktop || die "sed failed"
	fi

	# change configured db-type depending on useflags
	local dbtype="dict"

	if use sqlite; then
		if use eix; then
			dbtype="eixsql"
		else
			dbtype="sql"
		fi
	fi

	sed -i -e "s;^\(type\s*=\s*\).*;\1${dbtype};" etc/portato.cfg || die "sed failed"
}

src_compile ()
{
	if use nls; then
		./pocompile.sh -emerge ${LINGUAS} || die "pocompile failed"
	fi

	if ! use eix || ! use sqlite; then
		distutils_src_compile --disable-eix
	else
		distutils_src_compile
	fi
}

src_install ()
{
	if ! use eix || ! use sqlite; then
		distutils_src_install --disable-eix
	else
		distutils_src_install
	fi

	newbin portato.py portato || die "newbin failed"
	dodoc doc/* || die "dodoc failed"

	# config
	insinto /etc
	doins etc/* || die "installing config files failed"

	# desktop
	doicon icons/portato-icon.png || die "doicon failed"
	domenu portato.desktop || die "domenu failed"

	# nls
	if use nls && [ -d i18n/mo ]; then
		domo i18n/mo/*
	fi

	# man page
	doman portato.1
}

pkg_postinst ()
{
	distutils_pkg_postinst
	python_mod_optimize "${PLUGIN_DIR}"

	if use eix && use sqlite; then
		einfo
		elog "If you are using eix-remote there is no guarantee,"
		elog "that portato will work as expected with the eixsql database."
		elog "If in doubt, change back to sql."
	fi
}

pkg_postrm ()
{
	distutils_pkg_postrm
	python_mod_cleanup "${PLUGIN_DIR}"

	# try to remove the DATA_DIR, as it may still exist
	# reason: it was tried to remove it before plugin stuff was purged
	rmdir "${ROOT}"$(dirname ${PLUGIN_DIR}) 2> /dev/null
}
