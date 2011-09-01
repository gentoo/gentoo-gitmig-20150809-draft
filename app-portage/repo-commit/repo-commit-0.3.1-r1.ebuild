# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/repo-commit/repo-commit-0.3.1-r1.ebuild,v 1.1 2011/09/01 07:21:39 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="A repository commit helper"
HOMEPAGE="https://github.com/mgorny/repo-commit/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-portage/gentoolkit-dev
	sys-apps/portage"
