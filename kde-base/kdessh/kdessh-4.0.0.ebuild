# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdessh/kdessh-4.0.0.ebuild,v 1.1 2008/01/17 23:55:06 philantrop Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE frontend to ssh"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="${RDEPEND} virtual/ssh"
