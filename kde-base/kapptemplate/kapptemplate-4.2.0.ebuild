# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-4.2.0.ebuild,v 1.1 2009/01/27 16:35:35 alexxy Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KAppTemplate - A shell script to create the necessary framework to develop KDE applications."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

# Fails, checked revision 810882.
RESTRICT="test"
