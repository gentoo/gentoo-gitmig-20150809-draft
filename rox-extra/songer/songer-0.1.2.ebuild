# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/songer/songer-0.1.2.ebuild,v 1.1 2004/12/09 19:15:33 sergey Exp $

DESCRIPTION="Songer - An ID3 tag editor for the ROX Desktop"

HOMEPAGE="http://songer.sf.net"

SRC_URI="mirror://sourceforge/songer/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.10

APPNAME=Songer

#S=${WORKDIR}

inherit rox
