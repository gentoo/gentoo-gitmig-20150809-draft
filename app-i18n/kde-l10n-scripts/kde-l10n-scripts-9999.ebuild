# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-l10n-scripts/kde-l10n-scripts-9999.ebuild,v 1.1 2012/08/03 20:10:42 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/vpelcak/kde-scripts.git"
[[ ${PV} == 9999 ]] && inherit git-2

DESCRIPTION="Set of scripts to manage KDE translation files."
HOMEPAGE="https://github.com/vpelcak/kde-scripts"
[[ ${PV} == 9999 ]] || SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-i18n/pology
	app-shells/bash
	dev-vcs/subversion
"
DEPEND="${RDEPEND}"
