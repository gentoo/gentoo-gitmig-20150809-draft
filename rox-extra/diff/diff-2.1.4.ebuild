# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/diff/diff-2.1.4.ebuild,v 1.2 2006/10/04 15:01:52 lack Exp $

ROX_CLIB_VER=2.1.8
inherit rox

MY_PN="Diff"
DESCRIPTION="This diff program for ROX that provides DND functionality.  By Stephen Watson"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/diff.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

KEEP_SRC=true

APPNAME=${MY_PN}
S=${WORKDIR}

