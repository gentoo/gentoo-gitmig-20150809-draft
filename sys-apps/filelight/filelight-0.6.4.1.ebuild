# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/filelight/filelight-0.6.4.1.ebuild,v 1.1 2004/03/07 22:37:04 centic Exp $

inherit kde-base
need-kde 3

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/${PN}/${PN}-0.6.4-1.tar.gz"

S=${WORKDIR}/${PN}-0.6.4

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

