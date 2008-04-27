# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/wammu/wammu-0.25.ebuild,v 1.3 2008/04/27 19:53:12 maekke Exp $

inherit distutils eutils versionator

DESCRIPTION="front-end for gammu (Nokia and other mobiles)"
HOMEPAGE="http://www.cihar.com/gammu/wammu/"
SRC_URI="http://dl.cihar.com/wammu/v0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="bluetooth"

RDEPEND="=dev-python/wxpython-2.6*
	>=dev-python/python-gammu-0.24
	bluetooth? (
		|| (
			dev-python/pybluez
			net-wireless/gnome-bluetooth
		)
	)"
DEPEND="${RDEPEND}"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" af ca cs de es et fi fr hu it ko nl pl pt_BR ru sk sv zh_CN"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	# Select the suitable wxpython versions
	local wxpy_pkg wxpy_slot MY_WXPYTHON_SLOTS
	for wxpy_pkg in $(portageq match "${ROOT}" '=dev-python/wxpython-2.6*'); do
		if built_with_use --hidden --missing false =${wxpy_pkg} unicode ; then
			wxpy_slot=$(get_version_component_range 1-2 ${wxpy_pkg#*/*-})
			if [ -z "${MY_WXPYTHON_SLOTS}" ]; then
				MY_WXPYTHON_SLOTS="'${wxpy_slot}'"
			else
				MY_WXPYTHON_SLOTS="${MY_WXPYTHON_SLOTS}, '${wxpy_slot}'"
			fi
		fi
	done
	if [ -z "${MY_WXPYTHON_SLOTS}" ]; then
		eerror "None of the dev-python/wxpython installed versions have been built with Unicode support."
		eerror "Install wxpython with unicode USE flag enabled and try again."
		die "dev-python/wxpython is missing Unicode support"
	fi

	cd "${S}"
	sed -e "s/WXPYTHON_VER/${MY_WXPYTHON_SLOTS}/" \
		"${FILESDIR}"/${PN}-wxversion.patch \
		> "${T}"/${PN}-wxversion.patch
	epatch "${T}"/${PN}-wxversion.patch

	cd locale || die "locale directory not found"
	local lang
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if ! use linguas_${lang} ; then
			rm -r ${lang}
		fi
	done
}

src_compile() {
	# SKIPWXCHECK: else 'import wx' results in
	# Xlib: connection to ":0.0" refused by server
	SKIPWXCHECK=yes distutils_src_compile
}

src_install() {
	DOCS="AUTHORS FAQ NEWS"
	SKIPWXCHECK=yes distutils_src_install
}
