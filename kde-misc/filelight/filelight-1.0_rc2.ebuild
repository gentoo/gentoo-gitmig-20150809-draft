# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.0_rc2.ebuild,v 1.1 2006/08/23 16:28:40 carlo Exp $

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${P%_*}"

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/packages/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

need-kde 3.4
