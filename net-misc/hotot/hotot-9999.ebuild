# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hotot/hotot-9999.ebuild,v 1.1 2011/01/05 15:30:22 xmw Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils mercurial python

DESCRIPTION="lightweight & open source microblogging client"
HOMEPAGE="http://hotot.org"
SRC_URI=""
EHG_REPO_URI="https://${PN}.googlecode.com/hg/${PN}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/keybinder[python]
	dev-python/notify-python
	dev-python/python-distutils-extra
	>=dev-python/pywebkitgtk-1.1.8"
DEPEND="${RDEPEND}"
