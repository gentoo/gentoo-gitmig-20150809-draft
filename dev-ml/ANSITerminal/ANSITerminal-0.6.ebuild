# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ANSITerminal/ANSITerminal-0.6.ebuild,v 1.1 2012/03/28 13:00:59 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Module which offers basic control of ANSI compliant terminals"
HOMEPAGE="http://forge.ocamlcore.org/projects/ansiterminal/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/610/${P}.tar.gz"
LICENSE="LGPL-2.1-linking-exception LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=""
RDEPEND="${DEPEND}"
IUSE=""

DOCS=( "README.txt" "AUTHORS.txt" )
