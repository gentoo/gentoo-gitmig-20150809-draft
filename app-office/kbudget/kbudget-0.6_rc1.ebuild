# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kbudget/kbudget-0.6_rc1.ebuild,v 1.1 2003/12/24 20:55:45 caleb Exp $

inherit kde
need-kde 3.0

MY_P=${PN}-0.5.95

S=${WORKDIR}/${MY_P}
DESCRIPTION="A budgeting and money management program for KDE."
SRC_URI="http://www.garandnet.net/kbudget/downloads/${MY_P}.tar.bz2"
HOMEPAGE="http://www.garandnet.net/kbudget/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
