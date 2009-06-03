# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksirc/ksirc-3.5.10.ebuild,v 1.3 2009/06/03 14:11:24 ranger Exp $

KMNAME=kdenetwork
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE irc client"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility ssl"

RDEPEND="dev-lang/perl
		ssl? ( dev-perl/IO-Socket-SSL )"
