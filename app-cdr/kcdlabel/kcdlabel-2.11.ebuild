# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.11.ebuild,v 1.1 2003/04/23 12:34:40 pauldv Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/${P}-KDE3

DESCRIPTION="KCDLABEL is a cd label printing tool for kde"

HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~x86"

IUSE=""




