# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/skkserv/skkserv-0.ebuild,v 1.1 2011/04/13 15:00:49 ulm Exp $

EAPI=3

DESCRIPTION="Virtual for SKK server"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( app-i18n/skkserv
		app-i18n/mecab-skkserv
		app-i18n/multiskkserv
		app-i18n/rskkserv )"
