# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono-basic/mono-basic-2.6.2.ebuild,v 1.3 2010/07/12 17:46:46 fauli Exp $

EAPI=2

inherit go-mono mono multilib

DESCRIPTION="Visual Basic .NET Runtime and Class Libraries"
HOMEPAGE="http://www.go-mono.com"

LICENSE="LGPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RESTRICT="test"
