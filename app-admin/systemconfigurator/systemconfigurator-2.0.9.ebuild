# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemconfigurator/systemconfigurator-2.0.9.ebuild,v 1.2 2004/03/01 08:12:55 mr_bones_ Exp $

inherit perl-module
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${P}"
DESCRIPTION="Provide a consistant API for the configuration of system related items."
SRC_URI="mirror://sourceforge/systemconfig/${P}.tar.gz"
HOMEPAGE="http://sisuite.org/systemconfig/"
LICENSE="GPL-2"
DEPEND="dev-lang/perl
		dev-perl/AppConfig"
RDEPEND="${DEPEND}"
