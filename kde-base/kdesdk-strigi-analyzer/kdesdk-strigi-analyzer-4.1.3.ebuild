# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-strigi-analyzer/kdesdk-strigi-analyzer-4.1.3.ebuild,v 1.1 2008/11/09 01:58:01 scarabeus Exp $

EAPI="2"

KMNAME=kdesdk
KMMODULE=strigi-analyzer
inherit kde4-meta

DESCRIPTION="kdesdk: strigi plugins"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.9"
RDEPEND="${DEPEND}"
