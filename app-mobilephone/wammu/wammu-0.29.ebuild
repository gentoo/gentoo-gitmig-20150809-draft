# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/wammu/wammu-0.29.ebuild,v 1.1 2008/11/02 12:53:27 mrness Exp $

inherit distutils

DESCRIPTION="front-end for gammu (Nokia and other mobiles)"
HOMEPAGE="http://www.cihar.com/gammu/wammu/"
SRC_URI="http://dl.cihar.com/wammu/v0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth"

RDEPEND=">=dev-python/wxpython-2.8
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
MY_AVAILABLE_LINGUAS=" af ca cs de es et fi fr gl he hu it ko nl pl pt_BR ru sk sv zh_CN zh_TW"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	pushd "${S}"/locale || die "locale directory not found"
	local lang support_linguas=no
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if use linguas_${lang} ; then
			support_linguas=yes
			break
		fi
	done
	# install all languages when all selected LINGUAS aren't supported
	if [ "${support_linguas}" = "yes" ]; then
		for lang in ${MY_AVAILABLE_LINGUAS} ; do
			if ! use linguas_${lang} ; then
				rm -r ${lang}
			fi
		done
	fi
	popd
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
