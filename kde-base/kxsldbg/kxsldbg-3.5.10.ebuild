# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-3.5.10.ebuild,v 1.7 2009/07/12 11:14:11 armin76 Exp $
KMNAME=kdewebdev
EAPI="1"
inherit kde-meta flag-o-matic

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"
