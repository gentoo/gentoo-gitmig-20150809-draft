# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono-basic/mono-basic-2.2.9999.ebuild,v 1.1 2009/05/05 11:44:07 loki_val Exp $

EAPI=2

inherit go-mono mono multilib

DESCRIPTION="Visual Basic .NET Runtime and Class Libraries"
HOMEPAGE="http://www.go-mono.com"

LICENSE="LGPL-2 MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RESTRICT="test"

EAUTOBOOTSTRAP="no"
